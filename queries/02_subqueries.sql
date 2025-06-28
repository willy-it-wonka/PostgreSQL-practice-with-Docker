/****************************************************/
/*    Subqueries in the WHERE clause                */
/****************************************************/

-- A. Subquery returning a SINGLE value (scalar subquery).
-- Find employees earning above the average salary.
SELECT
    first_name,
    last_name,
    salary
FROM
    company.employees
WHERE
    salary > (
        SELECT
            AVG(salary)
        FROM
            company.employees
    );

-- B. Subquery returning a LIST of values (use with IN).
-- Find employees who live in 'Warsaw'.
SELECT
    *
FROM
    company.employees
WHERE
    id IN (
        SELECT
            employee_id
        FROM
            company.contacts
        WHERE
            city = 'Warsaw'
    );

-- C. EXISTS instead of IN (more efficient with large datasets).
-- Find employees who live in 'Warsaw'.
SELECT
    *
FROM
    company.employees e
WHERE
    EXISTS (
        SELECT
            1
        FROM
            company.contacts c
        WHERE
            c.employee_id = e.id
            AND c.city = 'Warsaw'
    );

-- D. Using NOT IN to exclude results.
-- Find all employees who do NOT live in 'London'.
SELECT
    *
FROM
    company.employees
WHERE
    id NOT IN (
        SELECT
            employee_id
        FROM
            company.contacts
        WHERE
            city = 'London'
    );
-- WARNING: If the subquery returns at least 1 NULL value, then the query will return 0 rows. 
-- It is better to use: NOT EXISTS
SELECT
    *
FROM
    company.employees e
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            company.contacts c
        WHERE
            c.employee_id = e.id
            AND c.city = 'London'
    );



/****************************************************/
/*    Subqueries in the FROM clause                 */
/****************************************************/

/* A subquery creates a virtual (derived) table, which the outer query can then filter, group, or sort. */

-- Find the average salary for each department.
SELECT
    department,
    avg_salary
FROM
    (
        SELECT
            department,
            AVG(salary) AS avg_salary
        FROM
            company.employees
        GROUP BY
            department
    ) AS department_avg
ORDER BY
    avg_salary DESC;



/****************************************************/
/*    Subqueries in the SELECT clause               */
/****************************************************/

/* It is used to add a new column to the result. For each row returned by the external query,
   the subquery is executed separately to calculate the value for this new column. 
   WARNING: it must return only one value (one row, one column). */

-- A. Retrieve a simple, related value.
-- Find each employee's email address and display it in a separate column.
SELECT
    e.first_name,
    e.last_name,
    (
        SELECT
            c.email
        FROM
            company.contacts c
        WHERE
            c.employee_id = e.id
    ) AS email
FROM
    company.employees e;
-- Good practice: use JOIN because N+1 problem.

-- B. Calculate an aggregate value related to the current row.
-- Find each employee's salary and the average salary of their department.
SELECT
    e.first_name,
    e.last_name,
    e.salary,
    e.department,
    (
        SELECT
            ROUND(AVG(sub.salary), 2)
        FROM
            company.employees sub
        WHERE
            sub.department = e.department
    ) AS department_avg_salary
FROM
    company.employees e;

-- C. Conditional logic in subqueries.
-- For each employee, check if they are the highest earner in their department.
SELECT
    e.first_name,
    e.last_name,
    e.salary,
    e.department,
    CASE
        WHEN e.salary = (
            SELECT
                MAX(sub.salary)
            FROM
                company.employees sub
            WHERE
                sub.department = e.department
        ) THEN 'Highest in department'
        ELSE 'Nope'
    END AS salary_status
FROM
    company.employees e;
