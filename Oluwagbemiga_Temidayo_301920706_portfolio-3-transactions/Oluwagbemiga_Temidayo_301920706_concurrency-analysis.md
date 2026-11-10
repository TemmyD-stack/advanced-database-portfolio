# Concurrency Control Analysis

## 1. Introduction

Concurrency control manages simultaneous database operations to prevent conflicts and maintain data consistency.

In a Hospital Management Information System (HMIS), multiple hospital staff may access or modify patient records at the same time. Without proper concurrency control, simultaneous updates could lead to inconsistent or unexpected results.

This experiment demonstrates row-level locking using MariaDB and the InnoDB storage engine.

## 2. Objectives

The objectives were to:

- Understand concurrency control in relational databases.
- Demonstrate row-level locking using SELECT ... FOR UPDATE.
- Observe how concurrent transactions interact when accessing the same record.
- Examine lock contention and lock wait timeouts.
- Understand how locking protects shared patient records.

## 3. Experimental Setup

Two independent MariaDB sessions were opened through the XAMPP Shell.

Both sessions accessed the `hospital_management` database and attempted to work with Olivia James's patient record (patient ID 101).

Session A acquired a lock on the selected patient record, while Session B attempted to update the same record.

## 4. SQL Implementation

### Session A: Acquire a Row-Level Lock

The first session started a transaction and selected Olivia's record using `FOR UPDATE`.

```sql
START TRANSACTION;

SELECT patient_id, first_name, last_name, address
FROM patients
WHERE patient_id = 101
FOR UPDATE;
```

The query successfully retrieved Olivia's record and acquired a lock on the selected row.

The transaction was intentionally left open to keep the lock active.

### Session B: Attempt a Concurrent Update

While Session A held the lock, Session B attempted to update the same patient record.

```sql
START TRANSACTION;

UPDATE patients
SET address = 'Updated by Session B'
WHERE patient_id = 101;
```

### Observation

Session B could not immediately complete the update because Session A held a lock on the same record.

The operation waited until MariaDB's configured lock wait timeout was reached.

MariaDB returned the following error:

```text
ERROR 1205 (HY000): Lock wait timeout exceeded;
try restarting transaction
```

This demonstrated lock contention between concurrent transactions.

## 5. Transaction Cleanup and Verification

After the failed update, Session B executed ROLLBACK.

```sql
ROLLBACK;
```

The patient's record was then checked using:

```sql
SELECT patient_id, first_name, last_name, address
FROM patients
WHERE patient_id = 101;
```

The address remained `Isolation Test Address`.

This confirmed that Session B's unsuccessful update did not overwrite the previously committed value.

## 6. Results Summary

| Session | Operation | Observed Result |
|---|---|---|
| Session A | SELECT ... FOR UPDATE | Successfully acquired a row-level lock |
| Session B | UPDATE the same patient record | Waited for the lock |
| Session B | UPDATE after waiting | Failed with error 1205 |
| Session B | ROLLBACK | Transaction cleanup performed |
| Session B | SELECT verification | Original committed address remained unchanged |

## 7. Analysis

The experiment demonstrated how InnoDB uses row-level locking to coordinate concurrent database operations.

Session A acquired a lock using SELECT ... FOR UPDATE. When Session B attempted to modify the same record, its update had to wait for the lock to be released.

The operation eventually exceeded the configured lock wait timeout and returned error 1205.

This showed that row-level locking helps prevent conflicting updates from proceeding simultaneously on the same locked record.

The experiment also demonstrated the importance of managing transaction duration. Long-running transactions can keep locks active and prevent other users from completing their operations.

## 8. Relevance to the HMIS

Concurrency control is important in hospital systems where doctors, nurses, laboratory staff, and administrative personnel may access shared patient information.

For example, when one staff member is updating a patient's details, another transaction attempting to modify the same record may need to wait.

Proper locking and transaction management help prevent conflicting updates and maintain the consistency of patient records.

## 9. Conclusion

The experiment successfully demonstrated row-level locking and lock contention using two independent MariaDB sessions.

The SELECT ... FOR UPDATE statement acquired a lock on the selected patient record, while a concurrent update from another session encountered a lock wait timeout.

The experiment highlighted the importance of concurrency control, transaction management, and appropriate lock handling in maintaining reliable hospital database operations.