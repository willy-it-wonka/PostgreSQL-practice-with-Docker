/****************************************************/
/*    Basic aggregation functions                   */
/****************************************************/

-- Count the total number of IT employees.
SELECT
    COUNT(*) AS it_employees
FROM
    company.employees
WHERE
    department = 'IT';

-- Count the number of unique departments.
SELECT
    COUNT(DISTINCT department) AS unique_departments
FROM
    company.employees;

-- Add up the total expenses for salaries for employees.
SELECT
    SUM(salary) AS total_salary
FROM
    company.employees;

-- Find the minimum and maximum salary.
SELECT
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM
    company.employees;

-- Find the average salary (rounded to 2 decimal places).
SELECT
    ROUND(AVG(salary), 2) AS avg_salary
FROM
    company.employees;
