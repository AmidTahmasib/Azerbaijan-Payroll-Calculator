# 🇦🇿 Azerbaijan Payroll Calculator (PL/SQL)

> A modular and law-compliant payroll engine built with Oracle PL/SQL based on Azerbaijani labor regulations. Supports gross-to-net salary, overtime pay, and vacation pay calculations with sector-specific tax logic.

---

## 📌 Project Overview

This project simulates payroll calculations in accordance with the labor code and tax regulations of Azerbaijan. It is developed entirely in Oracle PL/SQL, focusing on flexibility, modularity, and real-case applicability for both public and private sectors.

📂 Intended for:
- Technical portfolio demonstration
- PL/SQL and Oracle SQL practice
- Interview or test case scenarios
- Localized payroll simulation

---

## 🔧 Technologies Used

- **Oracle Database 19c+**
- **PL/SQL** (Procedures, Functions, Packages)
- **SQL Developer / DBeaver / TOAD** (Any Oracle IDE)

---

## 🧠 Key Functionalities

| Module                   | Description                                                                 |
|--------------------------|-----------------------------------------------------------------------------|
| `calculate_net_salary`   | Calculates net salary based on gross salary, sector, and tax exemption      |
| `get_rate`               | Helper function to fetch rate (percentage/fixed) based on code and sector   |
| `calculate_overtime_pay` | Based on excess hours over monthly/weekly norms                             |
| `calculate_vavation_pay` | Based on 12-month average salary and average month days (30.4)              |
| Minimum Salary Check     | Ensures final net is not below the legal minimum (400 AZN in 2025)          |

---

## 🗂️ Repository Structure

```bash
azerbaijan-payroll-calculator/
├── sql/
│   ├── create_tables.sql          # Main tables: employees, rates, work norms
│   ├── insert_sample_data.sql     # Sample data for testing
│   ├── payroll_pkg_spec.sql       # Package specification (interface)
│   ├── payroll_pkg_body.sql       # Core business logic (translated to English)
│   ├── test_calls.sql             # Test queries and DBMS_OUTPUT output
├── docs/
│   └── payroll_flowchart_az.png   # Optional architecture diagram
├── LICENSE                        # MIT License
└── README.md                      # This file
```

---

## ⚙️ How to Use

1. Run `create_tables.sql` to set up the schema
2. Load `insert_sample_data.sql` to populate test data
3. Execute `payroll_pkg_spec.sql` and `payroll_pkg_body.sql` to compile the package
4. Test the logic using `test_calls.sql`

---

## 🧪 Sample Test Execution

```sql
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
```

```
Net Salary: 1738.08
```

---

## 📈 Extension Possibilities

The current logic is stable and production-ready for simulation and demonstration. However, potential extensions include:

- [ ] **Prorated salary calculations** for mid-month entry/exit or part-time employees
- [ ] **Bonus, one-time payments** and performance-based allowances
- [ ] **Unit testing** via `utPLSQL` to ensure reliability and prevent regression
- [ ] **Performance optimization** for large-scale databases (indexing, bulk processing)
- [ ] **BI/Excel integration** for reporting (Power BI dashboards, salary slips, etc.)

---

## 💼 Design Considerations

- **Configurable rates:** All tax and deduction values are stored in the `payroll_rates` table
- **Sector-based logic:** Public vs Private tax rules are handled within package logic
- **Dynamic exemption mapping:** Based on `tax_exemptions` table
- **Exception handling:** Business-safe errors using `RAISE_APPLICATION_ERROR`
- **Maintainability:** Clear modular structure and sector separation

---

## 👨‍💻 Author

**Amid Tahmasib**  
📘 [Read the full technical article in Azerbaijani on Medium](https://amidtahmasib.medium.com/az%C9%99rbaycanda-%C9%99m%C9%99khaqq%C4%B1-hesablama-sistemi-pl-sql-il%C9%99-h%C9%99ll-3c5b77d62986)  
🔗 [LinkedIn Profile](https://www.linkedin.com/in/amidtahmasib/)

---

## 📄 License

This project is licensed under the MIT License — use, modify, and distribute freely.

---

## ⭐ Found it useful?

Leave a ⭐ on GitHub or share the repository with others!

