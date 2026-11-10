# Hospital Management Information System (HMIS)
## Portfolio 1: Database Design and Modelling

### 1. Case Study Background and Introduction

The Hospital Management Information System (HMIS) is a database-driven system designed to support the daily operations of a hospital or medical clinic. It provides a centralised platform for storing, organising, retrieving and managing important hospital information.

Hospitals handle large volumes of information relating to patients, doctors, appointments, diagnoses, prescriptions and laboratory investigations. Managing these records manually or through disconnected systems can lead to data duplication, inconsistent information, difficulty retrieving patient histories and delays in accessing important records.

The proposed HMIS addresses these challenges by implementing a relational database that connects the major areas of hospital operations. The system uses structured tables and relationships to maintain data consistency, support efficient information retrieval and reduce unnecessary duplication.

### 2. Problem Statement

Hospitals require an organised and reliable way to manage patient information and coordinate their daily activities. When records are maintained manually or stored in separate, disconnected systems, several problems may arise:

- Difficulty retrieving complete patient medical histories.
- Duplication of patient and medical records.
- Inconsistent or inaccurate information.
- Challenges in tracking appointments and doctor schedules.
- Difficulty monitoring prescriptions and laboratory investigations.
- Delays in accessing information needed for hospital operations.

A properly designed database is therefore required to centralise these records, establish relationships between them and enforce data integrity.

### 3. Aim of the Project

The aim of this project is to design and implement a relational database for a Hospital Management Information System that supports the structured storage, management and retrieval of hospital records.

### 4. Project Objectives

The objectives of the project are to:

1. Design an Entity Relationship Diagram (ERD) representing the major entities and relationships within the hospital system.
2. Convert the ERD into a relational database schema.
3. Implement the database using MySQL.
4. Apply primary keys, foreign keys and integrity constraints to maintain data accuracy and consistency.
5. Organise the database tables according to normalisation principles to minimise unnecessary data duplication.
6. Insert sample records to demonstrate how the database operates.
7. Use SQL queries and JOIN operations to retrieve meaningful information from related tables.
8. Evaluate query performance and explore database optimisation techniques in subsequent stages of the project.

### 5. Scope of the System

The database focuses on the following major areas of hospital operations:

- **Patient Management:** Stores patient identification details, contact information and basic demographic records.
- **Doctor Management:** Stores doctors' personal details and medical specialisations.
- **Appointment Management:** Records appointments between patients and doctors, including dates, reasons and appointment statuses.
- **Diagnosis Management:** Stores diagnoses, descriptions and treatments associated with appointments.
- **Prescription Management:** Maintains prescribed medications, dosages, frequencies, durations and instructions.
- **Laboratory Management:** Records laboratory investigations requested for patients and the doctors who request them.
- **Laboratory Results Management:** Stores findings and result details associated with laboratory tests.

The current implementation focuses on the database structure and SQL operations rather than a complete hospital application with a graphical user interface.

### 6. Database Users

The proposed system supports the information needs of different hospital personnel:

| User | Responsibilities |
|---|---|
| Hospital Administrators | Oversee hospital records and administrative information. |
| Doctors | Access patient records, appointments and diagnoses. |
| Nurses | Support patient care and access relevant patient information. |
| Laboratory Technicians | Manage laboratory investigations and record results. |
| Pharmacists | Access prescription information. |
| Receptionists | Register patients and manage appointment information. |

### 7. Data Requirements

The database stores the following categories of information:

| Data Category | Information Stored |
|---|---|
| Patients | Names, date of birth, gender, contact details and address. |
| Doctors | Names, specialisations, phone numbers and email addresses. |
| Appointments | Patient, doctor, appointment date, reason and status. |
| Diagnoses | Appointment reference, diagnosis name, description and treatment. |
| Prescriptions | Diagnosis reference, medication, dosage, frequency and instructions. |
| Laboratory Tests | Patient, requesting doctor, test name, description, date and status. |
| Laboratory Results | Test reference, result details, findings and result date. |

### 8. Key Database Operations

The database is designed to support the following operations:

1. Registering and retrieving patient records.
2. Storing doctor information and specialisations.
3. Scheduling and tracking patient appointments.
4. Recording diagnoses and associated treatments.
5. Managing prescriptions linked to diagnoses.
6. Recording laboratory investigations and their results.
7. Retrieving patient information across related tables using SQL JOIN operations.
8. Generating summary information using aggregate functions.

### 9. Database Design Overview

The HMIS database was implemented using MySQL with the InnoDB storage engine. It consists of seven relational tables:

1. `patients`
2. `doctors`
3. `appointments`
4. `diagnoses`
5. `prescriptions`
6. `laboratory_tests`
7. `laboratory_results`

Each table uses a primary key to uniquely identify its records. Foreign keys establish relationships between related tables and help maintain referential integrity.

The design also applies constraints such as `NOT NULL`, `UNIQUE` and `ENUM` to control the type and validity of stored information.

A design refinement was made to the diagnoses table: instead of storing separate patient and doctor references, it uses the appointment reference to retrieve the associated patient and doctor information. This reduces unnecessary duplication.

### 10. Project Limitations

The current project is a database design and implementation exercise. It uses fictional sample records and does not contain actual patient medical information.

It does not yet implement features such as user authentication, role-based access control, automated appointment notifications, payment processing or a complete graphical user interface. These would be considered in a full-scale hospital application.

### 11. Conclusion

The Hospital Management Information System provides a practical case study for exploring relational database design and implementation. Through the creation of seven related tables, the project demonstrates how hospital information can be structured, connected and retrieved using MySQL.

The database establishes a foundation for further investigation into query processing and optimisation, transaction management, concurrency control, NoSQL databases and distributed database systems in the subsequent portfolios.