# Portfolio 2: Query Processing and Optimisation

## Overview

This portfolio explores query processing and optimization techniques using the Hospital Management Information System (HMIS) database developed in Portfolio 1.

The exercise focused on examining query execution plans, creating indexes, comparing query performance, and evaluating how indexing and filtering influence database query execution.

## Case Study

**Hospital Management Information System (HMIS)**

The existing HMIS database was used to investigate query performance across patient, doctor, appointment, and related records.

## Database Environment

| Item | Description |
|---|---|
| Database Management System | MySQL / MariaDB |
| Database Name | hospital_management |
| Development Environment | XAMPP and phpMyAdmin |
| Storage Engine | InnoDB |

## Dataset

The database was populated with a larger dataset to support query processing and optimization experiments.

| Table | Number of Records |
|---|---:|
| Patients | 100 |
| Doctors | 25 |
| Appointments | 1,000 |
| Diagnoses | 800 |
| Prescriptions | 1,200 |
| Laboratory Tests | 800 |
| Laboratory Results | 650 |

## Optimization Experiments

Four experiment areas were investigated:

1. **Patients:** Examined queries involving patient records and evaluated indexing on patient names.
2. **Doctors:** Examined queries involving doctor specializations and tested specialization indexing.
3. **Appointments:** Evaluated appointment filtering and the use of a composite index on appointment date and status.
4. **JOIN Operations:** Examined queries involving related tables and evaluated the effect of filtering on query execution.

## Techniques Used

- SQL query execution using `EXPLAIN`.
- Index creation and evaluation.
- Single-column indexing.
- Composite indexing.
- Query filtering.
- Query execution plan comparison.
- Execution-time observations.

## Project Structure

The portfolio is organized into four experiment folders:

| Folder | Description |
|---|---|
| `patients/` | Patient query and indexing experiments |
| `doctors/` | Doctor query and indexing experiments |
| `appointments/` | Appointment query and composite indexing experiments |
| `join/` | JOIN query and filtering experiments |

Each experiment folder contains relevant SQL scripts, analysis documents, and screenshots of execution results.

## Outcome

The experiments demonstrated how indexes and query conditions can influence query execution plans and the number of rows examined.

The results also highlighted that performance improvements depend on factors such as table size, query structure, and indexing strategy. Execution-time measurements on relatively small datasets should therefore be interpreted cautiously.

## Tools Used

- MySQL / MariaDB
- XAMPP
- phpMyAdmin
- SQL
- EXPLAIN

