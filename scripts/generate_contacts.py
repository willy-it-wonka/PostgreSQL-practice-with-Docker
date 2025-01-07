import csv
import random

from faker import Faker

fake = Faker()
unique_emails = set()
cities = ['New York', 'London', 'Berlin', 'Warsaw', 'Paris', 'Rome']


def generate_unique_email():
    while True:
        email = fake.email()
        if email not in unique_emails:
            unique_emails.add(email)
            return email


def generate_contact_data(employee_id):
    return {
        'employee_id': employee_id,
        'email': generate_unique_email(),
        'phone_number': fake.phone_number(),
        'address': fake.address().replace("\n", ", "),
        'city': random.choice(cities),
        'postal_code': fake.zipcode()
    }


contacts = []
for emp_id in range(1, 501):
    contacts.append(generate_contact_data(emp_id))

with open('contacts.csv', mode='w', newline='', encoding='utf-8') as file:
    writer = csv.DictWriter(file, fieldnames=['employee_id', 'email', 'phone_number', 'address', 'city', 'postal_code'])
    writer.writeheader()
    writer.writerows(contacts)
