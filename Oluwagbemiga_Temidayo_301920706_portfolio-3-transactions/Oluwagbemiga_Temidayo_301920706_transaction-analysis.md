# Transaction Management Analysis

## 1. Introduction

This experiment demonstrates transaction management in the Hospital Management Information System (HMIS) using MySQL/MariaDB and the InnoDB storage engine.

Transactions allow database operations to be treated as logical units of work. The COMMIT command permanently saves successful changes, while ROLLBACK reverses changes that have not been committed.

## 2. Objectives

The objectives of this experiment were to:

- Demonstrate how to start a database transaction.
- Understand how COMMIT permanently saves database changes.
- Demonstrate how ROLLBACK reverses uncommitted changes.
- Examine the importance of transaction management in a hospital database.

## 3. Transaction COMMIT Experiment

### Scenario

A fictional patient, Olivia James, was registered in the HMIS database.

### SQL Implementation

```sql
START TRANSACTION;

INSERT INTO patients (first_name, last_name, email)
VALUES ('Olivia', 'James', 'olivia.james@hmis.test');

COMMIT;
```

### Verification

The following query was used to retrieve the newly registered patient:

```sql
SELECT *
FROM patients
WHERE patient_id = 101;
```

### Observation

The INSERT operation successfully created a patient record with patient ID **101**.

The COMMIT statement permanently saved the record. A subsequent SELECT query retrieved Olivia James's record, confirming that the transaction was committed.

The initial INSERT omitted the required `date_of_birth` and `gender` fields. MySQL returned warnings, and the record contained incomplete information, including an invalid zero date. The record was nevertheless inserted and committed successfully.

This observation highlights the importance of validating required patient information before committing a registration transaction.

## 4. Transaction ROLLBACK Experiment

### Scenario

A temporary patient registration was performed to demonstrate how an uncommitted database operation can be reversed.

### SQL Implementation

```sql
START TRANSACTION;

INSERT INTO patients (
    first_name,
    last_name,
    date_of_birth,
    gender,
    email
)
VALUES (
    'Daniel',
    'Williams',
    '1995-06-15',
    'Male',
    'daniel.williams.rollback@hmis.test'
);

SELECT *
FROM patients
WHERE email = 'daniel.williams.rollback@hmis.test';

ROLLBACK;
```

### Verification

After executing ROLLBACK, the following query was used:

```sql
SELECT *
FROM patients
WHERE email = 'daniel.williams.rollback@hmis.test';
```

The query returned an empty result set containing zero rows.

### Observation

The temporary patient record was successfully inserted within the transaction. However, the ROLLBACK command reversed the insertion because the transaction had not been committed.

The verification query confirmed that the temporary record was no longer present.

## 5. Comparison of COMMIT and ROLLBACK

| COMMIT | ROLLBACK |
|---|---|
| Permanently saves transaction changes. | Reverses uncommitted transaction changes. |
| Makes committed changes available to other transactions. | Cancels changes made within the transaction. |
| Used when database operations are successful. | Used when database operations need to be cancelled. |

## 6. Relevance to the HMIS

Transaction management is important in hospital systems because patient registration and other database operations must be handled reliably.

For example, a patient registration should only be committed after the required information has been validated. If an operation fails, ROLLBACK can prevent incomplete changes from being saved.

## 7. Conclusion

The experiments demonstrated the use of COMMIT and ROLLBACK in the HMIS database.

COMMIT successfully saved Olivia James's patient record with patient ID 101, while ROLLBACK reversed the temporary registration of Daniel Williams.

These operations demonstrate how transaction management supports database consistency and reliability in hospital information systems.