# Database Normalisation – Hospital Management Information System (HMIS)

## Introduction

The process of database normalisation involves organizing data into structured tables in order to minimise redundancy, prevent anomalies, and improve the integrity of data.

The Hospital Management Information System (HMIS) was designed using the principles of First Normal Form (1NF), Second Normal Form (2NF) and Third Normal Form (3NF).

The database consists of seven related tables:
1. Patients,
2. Doctors,
3. Appointments,
4. Diagnoses,
5. Prescriptions,
6. Laboratory Tests, and
7. Laboratory Results

## First Normal Form (1NF)

A database table satisfies First Normal Form when:

- Each column contains a single, atomic value.
- Each record can be uniquely identified using a primary key.
- Repeating groups and multiple values in a single column are avoided.

### Application in the HMIS

The HMIS satisfies 1NF because each table has a defined primary key, and individual attributes are stored in separate columns.

For example, the patients table stores first_name and last_name separately rather than combining patient names into a single field.

Similarly, doctors' specialisations, appointment dates and prescription details are stored in their respective columns.

**Outcome:** The database structure satisfies the requirements of First Normal Form.

## Second Normal Form (2NF)

A database table satisfies Second Normal Form when:
- It already satisfies 1NF.
- Every non-key attribute depends on the entire primary key.
- There are no partial dependencies on part of a composite primary key.

### Application in the HMIS
The HMIS uses single-column primary keys across its seven tables.

Examples include:
- patient_id in the patients table.
- doctor_id in the doctors table.
- appointment_id in the appointments table.
- diagnosis_id in the diagnoses table.
- prescription_id in the prescriptions table.

Since the tables use single-column primary keys, partial dependencies on part of a composite primary key do not arise.

**Outcome:** The database design satisfies the requirements of Second Normal Form.

## Third Normal Form (3NF)

A database table satisfies Third Normal Form when:
- It already satisfies 2NF.
- Non-key attributes depend directly on the primary key.
- Transitive dependencies between non-key attributes are eliminated.

### Application in the HMIS
The HMIS separates information into related tables to avoid unnecessary duplication.

For example:
- Patient details are stored in the patients table.
- Doctor details are stored in the doctors table.
- Appointment information is stored in the appointments table.
- Diagnosis information is stored in the diagnoses table.
- Medication information is stored in the prescriptions table.
- Laboratory test information is stored in the laboratory_tests table.
- Laboratory results are stored in the laboratory_results table.

Foreign keys establish relationships between these tables, allowing related information to be retrieved using SQL JOIN operations instead of repeatedly storing the same details.

**Outcome:** The revised database design is structured to satisfy Third Normal Form.

## Database Design Refinement

During the normalisation review, an improvement was made to the original diagnoses table.

### Original Structure

The original diagnoses table contained:

- diagnosis_id (Primary Key)
- patient_id (Foreign Key)
- doctor_id (Foreign Key)
- appointment_id (Foreign Key)
- diagnosis_name
- description
- treatment
- diagnosis_date

### Identified Issue

The patient_id and doctor_id columns were already available through the appointments table.

Storing these identifiers again in the diagnoses table introduced unnecessary duplication and could result in inconsistent records if the identifiers did not match the associated appointment.

### Revised Structure

The diagnoses table was modified to remove patient_id and doctor_id.

Its revised structure contains:
- diagnosis_id (Primary Key)
- appointment_id (Foreign Key)
- diagnosis_name
- description
- treatment
- diagnosis_date

The appointment_id column was also made mandatory to ensure that every diagnosis is associated with a recorded appointment.

### Outcome of the Refinement

The modification:
- Eliminated redundant patient and doctor identifiers.
- Reduced the possibility of inconsistent relationships.
- Strengthened referential integrity.
- Allowed patient and doctor information to be retrieved through the appointments table using SQL JOIN operations.

## Database Relationships

The revised database supports the following relationships:
- One patient can have multiple appointments.
- One doctor can attend multiple appointments.
- One appointment can have multiple diagnoses.
- One diagnosis can have multiple prescriptions.
- One patient can have multiple laboratory tests.
- One doctor can request multiple laboratory tests.
- One laboratory test can have one laboratory result.

These relationships are maintained using primary keys and foreign keys.

## Conclusion

The normalisation process helped organise the Hospital Management Information System into seven related tables.

The application of 1NF, 2NF and 3NF principles reduced unnecessary data duplication and improved the organisation of records.
A structural refinement was also made to the diagnoses table to eliminate redundant patient and doctor identifiers.
The resulting database provides a more consistent and maintainable structure for managing patient records, appointments, diagnoses, prescriptions and laboratory information.


