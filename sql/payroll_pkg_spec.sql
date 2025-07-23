-- PL/SQL package specification for payroll calculations

CREATE OR REPLACE PACKAGE payroll_pkg AS
    -- Calculates the employee's monthly net salary
    FUNCTION calculate_net_salary (
        p_employee_id      NUMBER,           -- Employee ID
        p_salary_month     DATE,             -- Month to be calculated
        p_sector           VARCHAR2,         -- Sector ('public' or 'private')
        p_is_union_member  CHAR              -- Is union member ('Y' or 'N')
    ) RETURN NUMBER;

    -- Calculates the employee's average gross salary over the last 12 months
    FUNCTION get_employee_average_gross_salary (
        p_employee_id     NUMBER,           -- Employee ID
        p_current_date    DATE              -- Current date
    ) RETURN NUMBER;

    -- Retrieves tax and other rates
    FUNCTION get_rate (
        p_rate_code       VARCHAR2,         -- Rate code
        p_sector          VARCHAR2,         -- Sector
        p_gross_amount    NUMBER DEFAULT NULL, -- Gross amount
        p_return_fixed    BOOLEAN DEFAULT FALSE -- Returns fixed amount
    ) RETURN NUMBER;

    -- Calculates overtime pay
    FUNCTION calculate_overtime_pay (
        p_employee_id     NUMBER,           -- Employee ID
        p_salary_month    DATE,             -- Month to be calculated
        p_gross_salary    NUMBER,           -- Base gross salary
        p_sector          VARCHAR2          -- Sector
    ) RETURN NUMBER;

    -- Calculates vacation pay
    FUNCTION calculate_vacation_pay (
        p_employee_id     NUMBER,           -- Employee ID
        p_salary_month    DATE              -- Month including vacation
    ) RETURN NUMBER;

    -- Inserts employee salary data
    PROCEDURE insert_employee_salary (
        p_employee_id     NUMBER,           -- Employee ID
        p_gross_salary    NUMBER,           -- Gross salary
        p_salary_month    DATE,             -- Salary month
        p_vacation_days   NUMBER DEFAULT 0, -- Vacation days
        p_overtime_hours  NUMBER DEFAULT 0  -- Overtime hours
    );
END payroll_pkg;
/
