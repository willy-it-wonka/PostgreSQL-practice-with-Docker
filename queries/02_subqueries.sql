/****************************************************/
/*    Subqueries in WHERE clause                    */
/****************************************************/

-- Subquery returns a list of values (use with IN).
-- Find employees who live in 'Warsaw'.
SELECT * 
FROM company.employees 
WHERE id IN (
    SELECT employee_id
    FROM company.contacts 
    WHERE city = 'Warsaw'
);

-- Subquery returns a single value (scalar subquery).
-- Find employees earning above the average salary.
SELECT first_name, last_name, salary
FROM company.employees
WHERE salary > (
    SELECT AVG(salary) 
    FROM company.employees
);