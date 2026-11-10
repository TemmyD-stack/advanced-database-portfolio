# JOIN Query Analysis

## 1. Introduction

A JOIN operation allows data from multiple relational database tables to be retrieved using related columns.

In the Hospital Management Information System (HMIS), appointments are linked to patients and doctors through foreign keys. This experiment examines how MySQL processes queries that combine these three tables.

## 2. Objective

The objective is to:
- Retrieve appointment information together with patient and doctor details.
- Examine the execution plan of a three-table JOIN.
- Investigate how existing indexes affect JOIN query processing.
- Evaluate the execution time of the original and filtered JOIN queries.

## 3. Original JOIN Query

The first query retrieves all appointments alongside the corresponding patient and doctor information.

```sql
SELECT
    a.appointment_id,
    a.appointment_date,
    a.status,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    d.specialization
FROM appointments a
INNER JOIN patients p
    ON a.patient_id = p.patient_id
INNER JOIN doctors d
    ON a.doctor_id = d.doctor_id;
```

The query returned 1,000 records.

## 4. Filtered JOIN Query

A second query was introduced to retrieve only scheduled appointments within October 2026.

```sql
SELECT
    a.appointment_id,
    a.appointment_date,
    a.status,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    d.specialization
FROM appointments a
INNER JOIN patients p
    ON a.patient_id = p.patient_id
INNER JOIN doctors d
    ON a.doctor_id = d.doctor_id
WHERE a.appointment_date >= '2026-10-01 00:00:00'
  AND a.appointment_date < '2026-11-01 00:00:00'
  AND a.status = 'scheduled';
```

The filtered query returned nine records.

## 5. Query Execution Analysis

The original JOIN execution plan showed:

- Doctors: full table scan (`ALL`), with an estimated 25 rows.
- Appointments: indexed lookup (`ref`) using `fk_appointment_doctor`.
- Patients: primary-key lookup (`eq_ref`).

The filtered JOIN execution plan showed:

- Appointments: range scan (`range`) using `idx_appointments_date_status`, with an estimated 36 rows.
- Doctors: primary-key lookup (`eq_ref`).
- Patients: primary-key lookup (`eq_ref`).

MySQL changed the join order and started with appointments in the filtered query. This allowed it to use the composite index to narrow down the matching records before retrieving the related doctor and patient details.

## 6. Conclusion

The experiment demonstrates how JOIN queries combine related HMIS records and how filtering conditions can influence the database execution plan.

The filtered JOIN reused the existing composite index on the appointments table. No additional index was required for this experiment.