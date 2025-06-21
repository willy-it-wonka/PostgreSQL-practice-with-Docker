/****************************************************/
/*    Basic SELECT and filtering (WHERE)            */
/****************************************************/

-- Find all employees from the 'IT' department.
SELECT * FROM company.employees WHERE department = 'IT';

-- Select only the first name, last name, and position for all employees.
SELECT first_name, last_name, position FROM company.employees;

-- Find employees earning more than 8000.
SELECT * FROM company.employees WHERE salary > 8000;

-- Find employees in the 'IT' department earning more than 7000.
SELECT * FROM company.employees WHERE department = 'IT' AND salary > 7000;

-- Find employees whose salary is between 5000 and 6000 (inclusive).
SELECT * FROM company.employees WHERE salary BETWEEN 5000 AND 6000;

-- Find employees hired in the year 2022.
SELECT * FROM company.employees WHERE hire_date BETWEEN '2022-01-01' AND '2022-12-31';

-- Find employees from the 'Sales' or 'Marketing' departments.
SELECT * FROM company.employees WHERE department IN ('Sales', 'Marketing');

-- Find employees without an assigned position.
SELECT * FROM company.employees WHERE position IS NULL;

-- Find a list of (non-repeating) departments.
SELECT DISTINCT department FROM company.employees;



/****************************************************/
/*    SELECT according to a string pattern          */
/****************************************************/

-- Find employees whose first name starts with 'A'.
SELECT * FROM company.employees WHERE first_name LIKE 'A%';

-- Find employees whose last name ends with 'EZ (case-sensitive) = 0 rows.
SELECT * FROM company.employees WHERE last_name LIKE '%EZ';

-- Find employees whose last name ends with 'EZ (case-insensitive).
SELECT * FROM company.employees WHERE last_name ILIKE '%EZ';

-- Find employees whose position contains the word 'Manager'.
SELECT * FROM company.employees WHERE position LIKE '%Manager%';

-- Find employees whose first_name matches the pattern: 'A', any single character, 'a', any sequence of characters.
SELECT * FROM company.employees WHERE first_name LIKE 'A_a%';



/****************************************************/
/*    Sorting (ORDER BY) and LIMITing results       */
/****************************************************/

-- Find all employees and order by last name.
SELECT * FROM company.employees ORDER BY last_name ASC;

-- Find employees with IDs from 21 to 30 (pagination example).
SELECT * FROM company.employees ORDER BY id LIMIT 10 OFFSET 20;

-- Find the top 10 highest-paid employees.
SELECT * FROM company.employees ORDER BY salary DESC LIMIT 10;

-- Find the next 5 highest-paid employees (ranks 11 to 15 by salary).
SELECT * FROM company.employees ORDER BY salary DESC LIMIT 5 OFFSET 10;

-- Find the top 10 lowest-paid employees.
SELECT * FROM company.employees ORDER BY salary ASC LIMIT 10;

-- Find employees by department (A-Z), then by last name (A-Z).
SELECT department, last_name, first_name FROM company.employees ORDER BY department ASC, last_name ASC;
