create or replace PACKAGE BODY payroll_pkg AS

    -- Returns the rate or fixed amount based on the given rate code, sector, and gross amount
    FUNCTION get_rate (
        p_rate_code       VARCHAR2,
        p_sector          VARCHAR2,
        p_gross_amount    NUMBER DEFAULT NULL,
        p_return_fixed    BOOLEAN DEFAULT FALSE
    ) RETURN NUMBER IS
        v_rate_value      NUMBER;
        v_fixed_amount    NUMBER;
    BEGIN
        SELECT NVL(rate_value, 0), NVL(fixed_amount, 0)
        INTO v_rate_value, v_fixed_amount
        FROM payroll_rates
        WHERE rate_code = p_rate_code
          AND sector = p_sector
          AND (p_gross_amount IS NULL
               OR p_gross_amount BETWEEN min_gross_amount AND max_gross_amount
               OR (p_rate_code = 'MINIMUM_WAGE' AND p_gross_amount IS NULL))
        ORDER BY min_gross_amount DESC, max_gross_amount ASC
        FETCH FIRST 1 ROWS ONLY;

        RETURN CASE WHEN p_return_fixed THEN v_fixed_amount ELSE v_rate_value END;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RAISE;
    END get_rate;

   
 -- Calculates the employee's average gross salary over the last 12 months
  FUNCTION get_employee_average_gross_salary (
    p_employee_id     NUMBER,
    p_current_date    DATE
) RETURN NUMBER IS
    v_total_salary  NUMBER := 0;
    v_months_paid   NUMBER := 0;
    v_hire_date     DATE;
    v_start_date    DATE;
BEGIN
    -- Retrieve hire date
    SELECT hire_date INTO v_hire_date
    FROM employees
    WHERE employee_id = p_employee_id;

    -- Start date for the last 12 months
    v_start_date := ADD_MONTHS(p_current_date, -12);
    IF v_hire_date > v_start_date THEN
        v_start_date := v_hire_date;
    END IF;

    -- Sum of salaries and count of months paid
    SELECT NVL(SUM(gross_salary), 0),
           COUNT(gross_salary)
    INTO v_total_salary, v_months_paid
    FROM employee_salaries
    WHERE employee_id = p_employee_id
      AND salary_month BETWEEN v_start_date AND p_current_date;

    -- Return 0 if no salary paid for the months
    IF v_months_paid = 0 THEN
        RETURN 0;
    END IF;

    RETURN ROUND(v_total_salary / v_months_paid, 2);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END get_employee_average_gross_salary;

 
   -- Calculates overtime pay
    FUNCTION calculate_overtime_pay (
        p_employee_id     NUMBER,
        p_salary_month    DATE,
        p_gross_salary    NUMBER,
        p_sector          VARCHAR2
    ) RETURN NUMBER IS
        v_overtime_hours      NUMBER;
        v_hourly_rate         NUMBER;
        v_overtime_multiplier NUMBER;
        v_overtime_pay        NUMBER := 0;
        v_work_hours_norm     NUMBER;
    BEGIN
        SELECT NVL(overtime_hours, 0)
        INTO v_overtime_hours
        FROM employee_salaries
        WHERE employee_id = p_employee_id
          AND salary_month = p_salary_month;

        IF v_overtime_hours > 0 THEN
            SELECT work_hours_norm
            INTO v_work_hours_norm
            FROM monthly_work_norms
            WHERE month_id = TO_CHAR(p_salary_month, 'MM')
              AND work_year = TO_CHAR(p_salary_month, 'YYYY');

            v_hourly_rate := ROUND(p_gross_salary / v_work_hours_norm, 2);
            v_overtime_multiplier := get_rate('OVERTIME_RATE_MULTIPLIER', p_sector, NULL, FALSE);
            IF v_overtime_multiplier IS NULL THEN
                v_overtime_multiplier := 1.5;
            END IF;
            v_overtime_pay := ROUND(v_overtime_hours * v_hourly_rate * v_overtime_multiplier, 2);
        END IF;

        RETURN v_overtime_pay;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
        WHEN OTHERS THEN
            RAISE;
    END calculate_overtime_pay;

 
   -- Calculates vacation pay
    FUNCTION calculate_vacation_pay (
        p_employee_id     NUMBER,
        p_salary_month    DATE
    ) RETURN NUMBER IS
        v_vacation_days       NUMBER;
        v_avg_gross_salary    NUMBER;
        v_daily_rate          NUMBER;
        v_vacation_pay        NUMBER := 0;
    BEGIN
        SELECT NVL(vacation_days, 0)
        INTO v_vacation_days
        FROM employee_salaries
        WHERE employee_id = p_employee_id      
          AND salary_month = p_salary_month;


        IF v_vacation_days > 0 THEN
            v_avg_gross_salary := get_employee_average_gross_salary(p_employee_id, p_salary_month);
            v_daily_rate := ROUND(v_avg_gross_salary / 30.4, 2);
            v_vacation_pay := ROUND(v_daily_rate * v_vacation_days, 2);
        END IF;

        RETURN v_vacation_pay;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
        WHEN OTHERS THEN
            RAISE;
    END calculate_vacation_pay;

  
  -- Calculates net salary (with deductions and additional payments)
    FUNCTION calculate_net_salary (
        p_employee_id         NUMBER,
        p_salary_month        DATE,
        p_sector              VARCHAR2,
        p_is_union_member     CHAR
    ) RETURN NUMBER IS
        v_gross_salary        NUMBER;
        v_total_deductions    NUMBER := 0;
        v_income_tax          NUMBER := 0;
        v_dsmf_contribution   NUMBER := 0;
        v_unemployment_tax    NUMBER := 0;
        v_medical_insurance   NUMBER := 0;
        v_union_fee           NUMBER := 0;
        v_overtime_pay        NUMBER := 0;
        v_vacation_pay        NUMBER := 0;
        v_final_net_salary    NUMBER;
        v_taxable_amount      NUMBER;
        v_exemption_amount    NUMBER := 0;
        v_exemption_code      VARCHAR2(50);

 
       -- Retrieves tax exemption amount
        FUNCTION get_tax_exemption_amount (
            p_exemption_code  VARCHAR2
        ) RETURN NUMBER IS
            v_amount  NUMBER;
        BEGIN
            SELECT exemption_amount
            INTO v_amount
            FROM tax_exemptions
            WHERE exemption_code = p_exemption_code;

            RETURN ROUND(v_amount, 2);

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 0;
        END get_tax_exemption_amount;

    BEGIN
        -- Validates sector
        IF p_sector NOT IN ('public', 'private') THEN
            RAISE_APPLICATION_ERROR(-20008, 'Invalid sector value: ' || p_sector);
        END IF;

        -- Retrieves gross salary
        SELECT gross_salary
        INTO v_gross_salary
        FROM employee_salaries
        WHERE employee_id = p_employee_id
          AND salary_month = p_salary_month;

        DBMS_OUTPUT.PUT_LINE('DEBUG: Initial Gross Salary: ' || v_gross_salary);

        -- Calculates overtime and vacation pay
        v_overtime_pay := calculate_overtime_pay(p_employee_id, p_salary_month, v_gross_salary, p_sector);
        v_vacation_pay := calculate_vacation_pay(p_employee_id, p_salary_month);
        v_gross_salary := ROUND(v_gross_salary + v_overtime_pay + v_vacation_pay, 2);

        DBMS_OUTPUT.PUT_LINE('DEBUG: Gross Salary (After Overtime and Vacation): ' || v_gross_salary);

        -- Retrieves tax exemption
        SELECT exemption_code
        INTO v_exemption_code
        FROM employees
        WHERE employee_id = p_employee_id;

        IF v_exemption_code IS NOT NULL THEN
            v_exemption_amount := get_tax_exemption_amount(v_exemption_code);
        END IF;

        DBMS_OUTPUT.PUT_LINE('DEBUG: Tax Exemption (' || NVL(v_exemption_code, 'None') || '): ' || v_exemption_amount);

        -- Calculates taxable amount
        v_taxable_amount := GREATEST(v_gross_salary - v_exemption_amount, 0);
        DBMS_OUTPUT.PUT_LINE('DEBUG: Taxable Amount: ' || v_taxable_amount);

        -- Calculates DSMF contribution
        IF p_sector = 'private' THEN
            IF v_gross_salary <= 200 THEN
                v_dsmf_contribution := ROUND(v_gross_salary * get_rate('DSMF_RATE', p_sector, v_gross_salary, FALSE), 2);
            ELSE
                v_dsmf_contribution := ROUND(get_rate('DSMF_RATE', p_sector, v_gross_salary, TRUE) +
                                             (v_gross_salary - 200) * get_rate('DSMF_RATE', p_sector, v_gross_salary, FALSE), 2);
            END IF;

        ELSIF p_sector = 'public' THEN
            v_dsmf_contribution := ROUND(v_gross_salary * get_rate('DSMF_RATE', p_sector, v_gross_salary, FALSE), 2);
        END IF;

        v_total_deductions := ROUND(v_total_deductions + v_dsmf_contribution, 2);
        DBMS_OUTPUT.PUT_LINE('DEBUG: DSMF Contribution: ' || v_dsmf_contribution);

        -- Calculates unemployment insurance
        v_unemployment_tax := ROUND(v_gross_salary * get_rate('UNEMPLOYMENT_INSURANCE_RATE', p_sector, v_gross_salary, FALSE), 2);
        v_total_deductions := ROUND(v_total_deductions + v_unemployment_tax, 2);
        DBMS_OUTPUT.PUT_LINE('DEBUG: Unemployment Insurance: ' || v_unemployment_tax);

        -- Calculates medical insurance
        IF v_gross_salary <= 8000 THEN
            v_medical_insurance := ROUND(v_gross_salary * get_rate('MEDICAL_INSURANCE_RATE', p_sector, v_gross_salary, FALSE), 2);
        ELSE
            v_medical_insurance := ROUND(get_rate('MEDICAL_INSURANCE_RATE', p_sector, v_gross_salary, TRUE) +
                                         (v_gross_salary - 8000) * get_rate('MEDICAL_INSURANCE_RATE', p_sector, v_gross_salary, FALSE), 2);
        END IF;

        v_total_deductions := ROUND(v_total_deductions + v_medical_insurance, 2);
        DBMS_OUTPUT.PUT_LINE('DEBUG: Medical Insurance: ' || v_medical_insurance);

        -- Calculates union fee (if union member)
        IF p_is_union_member = 'Y' THEN
            v_union_fee := ROUND(v_gross_salary * get_rate('UNION_FEE_RATE', p_sector, v_gross_salary, FALSE), 2);
            v_total_deductions := ROUND(v_total_deductions + v_union_fee, 2);
            DBMS_OUTPUT.PUT_LINE('DEBUG: Union Fee: ' || v_union_fee);
        END IF;

        -- Calculates income tax
        IF p_sector = 'private' THEN
            IF v_taxable_amount <= 8000 THEN
                v_income_tax := 0;
            ELSE
                v_income_tax := ROUND((v_taxable_amount - 8000) * get_rate('INCOME_TAX_RATE', p_sector, v_taxable_amount, FALSE), 2);
            END IF;

        ELSIF p_sector = 'public' THEN
            IF v_taxable_amount <= 2500 THEN
                v_income_tax := ROUND(GREATEST(0, v_taxable_amount - 200) * get_rate('INCOME_TAX_RATE', p_sector, v_taxable_amount, FALSE), 2);
            ELSE
                v_income_tax := ROUND(get_rate('INCOME_TAX_RATE', p_sector, v_taxable_amount, TRUE) +
                                      (v_taxable_amount - 2500) * get_rate('INCOME_TAX_RATE', p_sector, v_taxable_amount, FALSE), 2);
            END IF;
        END IF;

        v_total_deductions := ROUND(v_total_deductions + v_income_tax, 2);
        DBMS_OUTPUT.PUT_LINE('DEBUG: Income Tax: ' || v_income_tax);
        DBMS_OUTPUT.PUT_LINE('DEBUG: Total Deductions: ' || v_total_deductions);

        -- Calculates final net salary
        v_final_net_salary := ROUND(v_gross_salary - v_total_deductions, 2);
        DBMS_OUTPUT.PUT_LINE('DEBUG: Calculated Net Salary (Before Minimum Wage Check): ' || v_final_net_salary);

        -- Checks minimum wage
        DECLARE
            v_min_wage  NUMBER;
        BEGIN
            v_min_wage := get_rate('MINIMUM_WAGE', p_sector, NULL, TRUE);
            DBMS_OUTPUT.PUT_LINE('DEBUG: Sector Minimum Wage: ' || v_min_wage);
            IF v_final_net_salary < v_min_wage THEN
                RAISE_APPLICATION_ERROR(-20007, 'Calculated net salary is below minimum wage. Minimum wage: ' || v_min_wage);
            END IF;
        END;

        RETURN v_final_net_salary;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20006, 'Error calculating net salary: ' || SQLERRM);
    END calculate_net_salary;


    -- Inserts employee salary data
    PROCEDURE insert_employee_salary (
        p_employee_id       NUMBER,
        p_gross_salary      NUMBER,
        p_salary_month      DATE,
        p_vacation_days     NUMBER DEFAULT 0,
        p_overtime_hours    NUMBER DEFAULT 0
    ) IS
    BEGIN
        INSERT INTO employee_salaries (
            employee_id,
            salary_month,
            gross_salary,
            vacation_days,
            overtime_hours
        ) VALUES (
            p_employee_id,
            p_salary_month,
            p_gross_salary,
            p_vacation_days,
            p_overtime_hours
        );

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20006, 'Error inserting salary data: ' || SQLERRM);
    END insert_employee_salary;

END payroll_pkg;
/