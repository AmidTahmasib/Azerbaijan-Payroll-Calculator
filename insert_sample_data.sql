-- Inserts sample data

-- Clears existing data
TRUNCATE TABLE employee_salaries;
TRUNCATE TABLE employees;
TRUNCATE TABLE tax_exemptions;
TRUNCATE TABLE monthly_work_norms;
TRUNCATE TABLE payroll_rates;

-- Sample employees
INSERT INTO employees (employee_id, first_name, last_name, hire_date, is_union_member, exemption_code)
VALUES (1, 'Vusal', 'Aliyev', TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), 'N', '102.1-1');
INSERT INTO employees (employee_id, first_name, last_name, hire_date, is_union_member, exemption_code)
VALUES (2, 'Aygun', 'Karimova', TO_DATE('15-MAR-2022', 'DD-MON-YYYY'), 'Y', '102-2');
INSERT INTO employees (employee_id, first_name, last_name, hire_date, is_union_member, exemption_code)
VALUES (3, 'Elvin', 'Mammadov', TO_DATE('01-SEP-2024', 'DD-MON-YYYY'), 'N', NULL);
INSERT INTO employees (employee_id, first_name, last_name, hire_date, is_union_member, exemption_code)
VALUES (4, 'Nigar', 'Huseynova', TO_DATE('10-FEB-2023', 'DD-MON-YYYY'), 'Y', '102-3');
INSERT INTO employees (employee_id, first_name, last_name, hire_date, is_union_member, exemption_code)
VALUES (5, 'Kamran', 'Gasimov', TO_DATE('20-JUL-2022', 'DD-MON-YYYY'), 'N', '102-4');
INSERT INTO employees (employee_id, first_name, last_name, hire_date, is_union_member, exemption_code)
VALUES (6, 'Leyla', 'Hasanova', TO_DATE('01-JAN-2025', 'DD-MON-YYYY'), 'N', NULL);


-- Employee salaries
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-MAY-2025', 'DD-MON-YYYY'), 1500.00, 10, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (2, TO_DATE('01-MAY-2025', 'DD-MON-YYYY'), 2000.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (3, TO_DATE('01-MAY-2025', 'DD-MON-YYYY'), 400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (4, TO_DATE('01-MAY-2025', 'DD-MON-YYYY'), 9000.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (5, TO_DATE('01-MAY-2025', 'DD-MON-YYYY'), 3000.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (6, TO_DATE('01-MAY-2025', 'DD-MON-YYYY'), 300.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-APR-2025', 'DD-MON-YYYY'), 1450.00, 0, 8);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (2, TO_DATE('01-MAR-2025', 'DD-MON-YYYY'), 2050.00, 10, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-APR-2024', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-MAR-2024', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-FEB-2024', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-JAN-2024', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-DEC-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-NOV-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-OCT-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-SEP-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-AUG-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-JUL-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-JUN-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-MAY-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-APR-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-MAR-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-FEB-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);
INSERT INTO employee_salaries (employee_id, salary_month, gross_salary, vacation_days, overtime_hours)
VALUES (1, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), 1400.00, 0, 0);


-- Tax exemptions
INSERT INTO tax_exemptions (exemption_code, exemption_amount) VALUES ('102.1-1', 800);
INSERT INTO tax_exemptions (exemption_code, exemption_amount) VALUES ('102-2', 400);
INSERT INTO tax_exemptions (exemption_code, exemption_amount) VALUES ('102-3', 200);
INSERT INTO tax_exemptions (exemption_code, exemption_amount) VALUES ('102-4', 100);
INSERT INTO tax_exemptions (exemption_code, exemption_amount) VALUES ('102-5', 50);

-- Monthly work norms
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (1, 2025, 17, 143);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (2, 2025, 20, 160);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (3, 2025, 12, 110);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (4, 2025, 21, 168);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (5, 2025, 15, 158);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (6, 2025, 15, 134);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (7, 2025, 23, 184);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (8, 2025, 21, 168);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (9, 2025, 22, 176);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (10, 2025, 23, 184);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (11, 2025, 17, 143);
INSERT INTO monthly_work_norms (month_id, work_year, work_days_norm, work_hours_norm) VALUES (12, 2025, 21, 175);

-- Payroll rates
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('INCOME_TAX_RATE', 'private', 0, 7999.99, 0, 'Income tax for private sector (exempt up to 8000 AZN)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('INCOME_TAX_RATE', 'private', 8000.00, 99999999.99, 0.14, 'Income tax for private sector (above 8000 AZN)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, fixed_amount, description)
VALUES ('INCOME_TAX_RATE', 'public', 0, 2499.99, 0.14, 200, 'Income tax for public sector (up to 2500 AZN, fixed deduction 200 AZN)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, fixed_amount, description)
VALUES ('INCOME_TAX_RATE', 'public', 2500.00, 99999999.99, 0.25, 350, 'Income tax for public sector (above 2500 AZN, fixed addition 350 AZN)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('DSMF_RATE', 'private', 0, 199.99, 0.03, 'DSMF for private sector (up to 200 AZN)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, fixed_amount, description)
VALUES ('DSMF_RATE', 'private', 200.00, 99999999.99, 0.10, 6, 'DSMF for private sector (above 200 AZN, fixed addition 6 AZN)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('DSMF_RATE', 'public', 0, 99999999.99, 0.03, 'DSMF for public sector');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('UNEMPLOYMENT_INSURANCE_RATE', 'private', 0, 99999999.99, 0.005, 'Unemployment insurance for private sector');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('UNEMPLOYMENT_INSURANCE_RATE', 'public', 0, 99999999.99, 0.005, 'Unemployment insurance for public sector');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('MEDICAL_INSURANCE_RATE', 'private', 0, 7999.99, 0.02, 'Medical insurance for private sector (up to 8000 AZN)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('MEDICAL_INSURANCE_RATE', 'public', 0, 7999.99, 0.02, 'Medical insurance for public sector (up to 8000 AZN)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, fixed_amount, description)
VALUES ('MEDICAL_INSURANCE_RATE', 'private', 8000.00, 99999999.99, 0.005, 160, 'Medical insurance for private sector (above 8000 AZN, fixed addition 160 AZN)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, fixed_amount, description)
VALUES ('MEDICAL_INSURANCE_RATE', 'public', 8000.00, 99999999.99, 0.005, 160, 'Medical insurance for public sector (above 8000 AZN, fixed addition 160 AZN)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('OVERTIME_RATE_MULTIPLIER', 'private', 0, 99999999.99, 1.5, 'Overtime rate multiplier (private sector)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('OVERTIME_RATE_MULTIPLIER', 'public', 0, 99999999.99, 1.5, 'Overtime rate multiplier (public sector)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, fixed_amount, description)
VALUES ('MINIMUM_WAGE', 'public', 0, 99999999.99, 0, 400.00, 'Minimum wage for public sector');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, fixed_amount, description)
VALUES ('MINIMUM_WAGE', 'private', 0, 99999999.99, 0, 400.00, 'Minimum wage for private sector');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('UNION_FEE_RATE', 'private', 0, 99999999.99, 0.01, 'Union fee rate (private sector)');
INSERT INTO payroll_rates (rate_code, sector, min_gross_amount, max_gross_amount, rate_value, description)
VALUES ('UNION_FEE_RATE', 'public', 0, 99999999.99, 0.01, 'Union fee rate (public sector)');

COMMIT;