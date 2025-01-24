CREATE TABLE IF NOT EXISTS employees (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10, 2),
    birthday DATE,
    hire_date DATE,
    department VARCHAR(50),
    position VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS contacts (
    employee_id INTEGER PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(50),
    address TEXT,
    city VARCHAR(100),
    postal_code VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
);