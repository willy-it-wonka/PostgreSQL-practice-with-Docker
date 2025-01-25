import csv
import random

from faker import Faker

fake = Faker()
DEPARTMENTS = ['IT', 'Marketing', 'Sales', 'Finance', 'Legal', 'HR']
DEPARTMENT_POSITIONS = {
    'IT': ['Back-end Developer', 'Front-end Developer', 'Network Administrator', 'DevOps Engineer'],
    'Marketing': ['Marketing Specialist', 'Social Media Manager', 'SEO Analyst'],
    'Sales': ['Sales Executive', 'Account Manager'],
    'Finance': ['Financial Analyst', 'Accountant', 'Tax Consultant'],
    'Legal': ['Lawyer', 'Legal Advisor', 'Contract Specialist'],
    'HR': ['HR Manager', 'Recruitment Specialist', 'HR Assistant']
}
FIELDNAMES = ['id', 'first_name', 'last_name', 'salary', 'birthday', 'hire_date', 'department', 'position']


def generate_employee_data(employee_id):
    department = random.choice(DEPARTMENTS)
    return {
        'id': employee_id,
        'first_name': fake.first_name(),
        'last_name': fake.last_name(),
        'salary': generate_salary(),
        'birthday': fake.date_of_birth(minimum_age=18, maximum_age=75).strftime('%Y-%m-%d'),
        'hire_date': fake.date_between(start_date='-10y', end_date='today').strftime('%Y-%m-%d'),
        'department': department,
        'position': random.choice(DEPARTMENT_POSITIONS[department]),
    }


def generate_salary(min_salary=3000, max_salary=10000):
    return round(random.uniform(min_salary, max_salary), 2)


def generate_employees(num_employees=500):
    return [generate_employee_data(emp_id) for emp_id in range(1, num_employees + 1)]


def save_employees_to_csv(employee_data, filename='employees.csv'):
    with open(filename, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.DictWriter(file, fieldnames=FIELDNAMES)
        writer.writeheader()
        writer.writerows(employee_data)


if __name__ == "__main__":
    employees = generate_employees()
    save_employees_to_csv(employees)
