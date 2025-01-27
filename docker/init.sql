CREATE SCHEMA IF NOT EXISTS company;

CREATE TABLE IF NOT EXISTS company.employees (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    birthday DATE NOT NULL,
    hire_date DATE NOT NULL,
    department VARCHAR(50) NOT NULL,
    position VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS company.contacts (
    employee_id INTEGER PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(30),
    address VARCHAR(200),
    city VARCHAR(50),
    postal_code VARCHAR(15),
    FOREIGN KEY (employee_id) REFERENCES company.employees(id) ON DELETE CASCADE
);