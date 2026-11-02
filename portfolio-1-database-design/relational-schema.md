# Relational Schema – Hospital Management Information System (HMIS)

## Introduction

The relational schema describes the logical structure of the Hospital Management Information System (HMIS). It identifies the database relations, their attributes, primary keys, foreign keys and constraints.

The system consists of seven relational tables designed to manage patient records, doctors, appointments, diagnoses, prescriptions and laboratory information.

## Relational Schema Notation

The following notation is used:

- PK – Primary Key
- FK – Foreign Key
- UNIQUE – Ensures that a value does not appear more than once.
- NOT NULL – Ensures that a field cannot contain a NULL value.

## Database Relations

### PATIENTS

PATIENTS(**patient_id**, first_name, last_name, date_of_birth, gender, phone, email, address, created_at)

- Primary Key: patient_id
- Unique attributes: phone, email

### DOCTORS

DOCTORS(**doctor_id**, first_name, last_name, specialization, phone, email, created_at)

- Primary Key: doctor_id
- Unique attributes: phone, email

### APPOINTMENTS

APPOINTMENTS(**appointment_id**, patient_id, doctor_id, appointment_date, reason, status, created_at)

- Primary Key: appointment_id
- Foreign Key: patient_id references PATIENTS(patient_id)
- Foreign Key: doctor_id references DOCTORS(doctor_id)

### DIAGNOSES

DIAGNOSES(**diagnosis_id**, appointment_id, diagnosis_name, description, treatment, diagnosis_date)

- Primary Key: diagnosis_id
- Foreign Key: appointment_id references APPOINTMENTS(appointment_id)
- appointment_id is NOT NULL.

### PRESCRIPTIONS

PRESCRIPTIONS(**prescription_id**, diagnosis_id, medication_name, dosage, frequency, duration, instructions, prescribed_at)

- Primary Key: prescription_id
- Foreign Key: diagnosis_id references DIAGNOSES(diagnosis_id)

### LABORATORY_TESTS

LABORATORY_TESTS(**test_id**, patient_id, doctor_id, test_name, test_description, test_date, status)

- Primary Key: test_id
- Foreign Key: patient_id references PATIENTS(patient_id)
- Foreign Key: doctor_id references DOCTORS(doctor_id)

### LABORATORY_RESULTS

LABORATORY_RESULTS(**result_id**, test_id, result_details, findings, result_date)

- Primary Key: result_id
- Foreign Key: test_id references LABORATORY_TESTS(test_id)
- UNIQUE constraint: test_id
- test_id is NOT NULL.

## Relationship Summary

The database contains the following relationships:

| Parent Relation | Child Relation | Cardinality |
|---|---|---|
| PATIENTS | APPOINTMENTS | One-to-Many |
| DOCTORS | APPOINTMENTS | One-to-Many |
| APPOINTMENTS | DIAGNOSES | One-to-Many |
| DIAGNOSES | PRESCRIPTIONS | One-to-Many |
| PATIENTS | LABORATORY_TESTS | One-to-Many |
| DOCTORS | LABORATORY_TESTS | One-to-Many |
| LABORATORY_TESTS | LABORATORY_RESULTS | One-to-Zero-or-One |

## Integrity Constraints

The HMIS uses several constraints to maintain data accuracy and consistency:

1. Primary key constraints uniquely identify records in each table.
2. Foreign key constraints maintain valid relationships between related tables.
3. NOT NULL constraints ensure that required information is provided.
4. UNIQUE constraints prevent duplicate patient phone numbers, email addresses and laboratory result references.
5. AUTO_INCREMENT automatically generates unique numeric identifiers.
6. ENUM constraints restrict appointment and laboratory test statuses to predefined values.

## Conclusion

The relational schema provides a structured representation of the HMIS database. Primary keys, foreign keys and integrity constraints establish relationships between the seven tables and support consistent storage and retrieval of hospital information.