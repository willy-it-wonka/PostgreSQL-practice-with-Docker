import csv
import random

from faker import Faker

fake = Faker()
unique_emails = set()
CITIES = ['New York', 'London', 'Berlin', 'Warsaw', 'Paris', 'Rome']
FIELDNAMES = ['employee_id', 'email', 'phone_number', 'address', 'city', 'postal_code']


def generate_contact_data(employee_id):
    return {
        'employee_id': employee_id,
        'email': generate_unique_email(),
        'phone_number': fake.phone_number(),
        'address': fake.address().replace("\n", ", "),
        'city': random.choice(CITIES),
        'postal_code': fake.zipcode()
    }


def generate_unique_email():
    while True:
        email = fake.email()
        if email not in unique_emails:
            unique_emails.add(email)
            return email


def generate_contacts(num_contacts=500):
    return [generate_contact_data(emp_id) for emp_id in range(1, num_contacts + 1)]


def save_contacts_to_csv(contact_data, filename='contacts.csv'):
    with open(filename, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.DictWriter(file, fieldnames=FIELDNAMES)
        writer.writeheader()
        writer.writerows(contact_data)


if __name__ == "__main__":
    contacts = generate_contacts()
    save_contacts_to_csv(contacts)
