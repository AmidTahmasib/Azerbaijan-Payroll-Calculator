
-- Test 1 – Net Salary (Employee 2, May 2025, Private sector, not a member, with exemption)
DECLARE
    v_net_salary NUMBER;
BEGIN
    v_net_salary := payroll_pkg.calculate_net_salary(
        p_employee_id      => 1,
        p_salary_month     => TO_DATE('01.05.2025', 'DD.MM.YYYY'),
        p_sector           => 'public',
        p_is_union_member  => 'N'
    );
    DBMS_OUTPUT.PUT_LINE('Net Salary: ' || v_net_salary);
END;
/

-- Test 2 – Net Salary (Employee 2, May 2025, public sector, not a member, with exemption)
DECLARE
    v_salary NUMBER;
BEGIN
    v_salary := payroll_pkg.calculate_net_salary(2, TO_DATE('01.05.2025','DD.MM.YYYY'), 'public', 'N');
    DBMS_OUTPUT.PUT_LINE('Net Salary: ' || v_salary);
END;
/



-- Test 3 – Overtime Pay (Employee 1, April 2025, 8 hours)
DECLARE
    v_overtime NUMBER;
BEGIN
    v_overtime := payroll_pkg.calculate_overtime_pay(1, TO_DATE('01.04.2025','DD.MM.YYYY'), 1450, 8);
    DBMS_OUTPUT.PUT_LINE('Overtime Pay: ' || v_overtime);
END;
/




-- Test 4 – Vacation Pay (Employee 2, 10 days)
DECLARE
    v_vacation NUMBER;
BEGIN
    v_vacation := payroll_pkg.calculate_vacation_pay(2, TO_DATE('01.03.2025','DD.MM.YYYY'));
    DBMS_OUTPUT.PUT_LINE('Vacation Pay: ' || v_vacation);
END;
/


-- Test 5 – Net Salary (Employee 4, May 2025, private sector, union member)
DECLARE
    v_salary NUMBER;
BEGIN
    v_salary := payroll_pkg.calculate_net_salary(4, TO_DATE('01.05.2025','DD.MM.YYYY'), 'private', 'Y');
    DBMS_OUTPUT.PUT_LINE('Net Salary: ' || v_salary);
END;
/



-- Test 6 – Net Salary (Employee 4, March 2025, no data – NULL expected)
DECLARE
    v_salary NUMBER;
BEGIN
    v_salary := payroll_pkg.calculate_net_salary(4, TO_DATE('01.03.2025','DD.MM.YYYY'), 'private', 'N');

    IF v_salary IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Net Salary: NULL (salary data not found)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Net Salary: ' || v_salary);
    END IF;
END;
/