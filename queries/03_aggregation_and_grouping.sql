/****************************************************/
/*    Basic aggregation functions                   */
/****************************************************/

/* Used to perform calculations on sets of values. */

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



/****************************************************/
/*    Grouping data with GROUP BY                   */
/****************************************************/

/* Used with aggregate functions to group rows with the same values. */

-- Count the number of employees in each department.
SELECT
    department,
    COUNT(*) AS employee_count
FROM
    company.employees
GROUP BY
    department;

-- Count the average salary by department.
SELECT
    department,
    ROUND(AVG(salary), 2) AS avg_salary
FROM
    company.employees
GROUP BY
    department;

-- Count the total salary cost by department.
SELECT
    department,
    SUM(salary) AS total_salary
FROM
    company.employees
GROUP BY
    department;

-- Count employees by department and position.
SELECT
    department,
    position,
    COUNT(*) as employee_count
FROM
    company.employees
GROUP BY
    department,
    position
ORDER BY
    department,
    position;



/****************************************************/
/*    Filtering groups with HAVING                  */
/****************************************************/

/* HAVING is used to filter groups after aggregation. WHERE filters rows before aggregation. */

-- Find departments that have more than 30 employees.
SELECT
    department,
    COUNT(*) AS employee_count
FROM
    company.employees
GROUP BY
    department
HAVING
    COUNT(*) > 30
ORDER BY
    employee_count;

-- Find departments where the average salary is less than 6666.
SELECT
    department,
    ROUND(AVG(salary), 2) AS avg_salary
FROM
    company.employees
GROUP BY
    department
HAVING
    AVG(salary) < 6666;
