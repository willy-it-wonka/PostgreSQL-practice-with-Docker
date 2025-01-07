import csv
import random

from faker import Faker

fake = Faker()
departments = ['IT', 'Marketing', 'Sales', 'Finance', 'Legal', 'HR']
department_positions = {
    'IT': ['Back-end Developer', 'Front-end Developer', 'Network Administrator', 'DevOps Engineer'],
    'Marketing': ['Marketing Specialist', 'Social Media Manager', 'SEO Analyst'],
    'Sales': ['Sales Executive', 'Account Manager'],
    'Finance': ['Financial Analyst', 'Accountant', 'Tax Consultant'],
    'Legal': ['Lawyer', 'Legal Advisor', 'Contract Specialist'],
    'HR': ['HR Manager', 'Recruitment Specialist', 'HR Assistant']
}


def generate_employee_data(employee_id):
    department = random.choice(departments)
    return {
        'id': employee_id,
        'first_name': fake.first_name(),
        'last_name': fake.last_name(),
        'salary': round(random.uniform(3000, 10000), 2),
        'birthday': fake.date_of_birth(minimum_age=18, maximum_age=75).strftime('%Y-%m-%d'),
        'hire_date': fake.date_between(start_date='-10y', end_date='today').strftime('%Y-%m-%d'),
        'department': department,
        'position': random.choice(department_positions[department]),
    }


employees = []
for emp_id in range(1, 501):
    employees.append(generate_employee_data(emp_id))

with open('employees.csv', mode='w', newline='', encoding='utf-8') as file:
    writer = csv.DictWriter(file, fieldnames=['id', 'first_name', 'last_name', 'salary', 'birthday', 'hire_date', 'department', 'position'])
    writer.writeheader()
    writer.writerows(employees)
