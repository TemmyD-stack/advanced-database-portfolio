# Transaction Isolation Analysis

## 1. Introduction

Transaction isolation controls how database transactions interact when multiple users or sessions access the same data simultaneously.

This experiment demonstrates the READ COMMITTED isolation level using two independent MariaDB sessions connected to the Hospital Management Information System (HMIS).

## 2. Objectives

The objectives were to:

- Understand transaction isolation in relational databases.
- Demonstrate the READ COMMITTED isolation level.
- Observe how uncommitted changes are hidden from other transactions.
- Demonstrate how committed changes become visible to other sessions.
- Understand how isolation prevents dirty reads.

## 3. Experimental Setup

Two independent MariaDB command-line sessions were opened through the XAMPP Shell.

- **Session A:** Modified Olivia James's patient record (patient ID 101).
- **Session B:** Retrieved the same patient record while Session A's transaction was active.

The READ COMMITTED isolation level was configured in both sessions.

## 4. SQL Implementation

### Session A: Begin Transaction and Update Record

```sql
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

UPDATE patients
SET address = 'Isolation Test Address'
WHERE patient_id = 101;
```

The update affected one row. However, the change was not immediately committed.

### Session B: Read the Patient Record

```sql
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT patient_id, first_name, last_name, address
FROM patients
WHERE patient_id = 101;
```

### Observation Before COMMIT

Session B returned Olivia James's address as `NULL`, even though Session A had updated it to `Isolation Test Address`.

This demonstrated that Session B could not access Session A's uncommitted changes.

It also demonstrated the prevention of a dirty read.

### Session A: Commit the Transaction

```sql
COMMIT;
```

Session A successfully committed the address update.

### Session B: Retrieve the Record Again

The following query was executed again in Session B:

```sql
SELECT patient_id, first_name, last_name, address
FROM patients
WHERE patient_id = 101;
```

### Observation After COMMIT

Session B returned the address as `Isolation Test Address`.

This confirmed that the committed change became visible to the other transaction.

## 5. Results Summary

| Experimental Stage | Session B Observation |
|---|---|
| Before Session A commits | Address remained NULL |
| After Session A commits | Address became Isolation Test Address |
| After an interrupted transaction in an earlier attempt | Address remained NULL |

## 6. Additional Observation: Automatic Rollback

During an earlier attempt, Session A was disconnected before the transaction was committed.

After reconnecting and checking Olivia's record, the address was still `NULL`.

This demonstrated that MariaDB rolled back the uncommitted update when the connection terminated.

The successful isolation experiment was subsequently repeated using two independent MariaDB sessions, and the expected results were obtained.

## 7. Analysis

The experiment demonstrated how READ COMMITTED isolation controls data visibility between concurrent transactions.

Before Session A committed its update, Session B could only access the previously committed value.

After COMMIT, the updated value became visible to Session B.

The experiment therefore demonstrated how READ COMMITTED prevents dirty reads and supports reliable access to shared database records.

## 8. Relevance to the HMIS

In a hospital information system, multiple staff members may access the same patient information.

For example, a doctor and an administrative staff member may access a patient's record while another transaction is updating it.

Transaction isolation helps ensure that users do not read changes that have not yet been committed.

## 9. Conclusion

The experiment successfully demonstrated transaction isolation using two independent MariaDB sessions.

The READ COMMITTED isolation level prevented one transaction from reading another transaction's uncommitted changes.

This is important in an HMIS environment because reliable access to committed patient information supports data consistency and accurate hospital operations.