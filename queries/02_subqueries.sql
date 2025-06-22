/****************************************************/
/*    Subqueries in the WHERE clause                */
/****************************************************/

-- A. Subquery returning a LIST of values (use with IN).
-- Find employees who live in 'Warsaw'.
SELECT * 
FROM company.employees 
WHERE id IN (
    SELECT employee_id
    FROM company.contacts 
    WHERE city = 'Warsaw'
);

-- B. Subquery returns a SINGLE value (scalar subquery).
-- Find employees earning above the average salary.
SELECT first_name, last_name, salary
FROM company.employees
WHERE salary > (
    SELECT AVG(salary) 
    FROM company.employees
);



/****************************************************/
/*    Subqueries in the FROM clause                 */
/****************************************************/

-- A subquery creates a virtual (derived) table, which the outer query can then filter, group, or sort.
-- Find the average salary for each department.
SELECT department, avg_salary
FROM (
    SELECT department, AVG(salary) AS avg_salary
    FROM company.employees
    GROUP BY department
) AS department_avg
ORDER BY avg_salary DESC;


