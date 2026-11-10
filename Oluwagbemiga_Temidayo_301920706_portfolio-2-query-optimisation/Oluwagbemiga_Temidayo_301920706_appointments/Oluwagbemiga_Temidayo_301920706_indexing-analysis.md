# Appointments Indexing Analysis

## 1. Introduction

Indexing is a database optimisation technique that helps MySQL locate records more efficiently without examining every row in a table.

This experiment uses a composite index on the `appointment_date` and `status` columns of the HMIS appointments table.

## 2. Indexing Objective

The objective is to optimise queries that retrieve appointments within a particular date range and with a specified status.

## 3. Execution Plan Before Indexing

The following command was used to examine the original execution plan:

```sql
EXPLAIN
SELECT *
FROM appointments
WHERE appointment_date >= '2026-10-01 00:00:00'
  AND appointment_date < '2026-11-01 00:00:00'
  AND status = 'scheduled';
```

Results:

| Property | Result |
|---|---|
| Access type (`type`) | ALL |
| Possible keys | NULL |
| Selected key (`key`) | NULL |
| Estimated rows | 1,000 |
| Extra | Using where |

MySQL performed a full table scan, estimating that all 1,000 records could be examined.

## 4. Creating the Composite Index

The following SQL statement was executed:

```sql
CREATE INDEX idx_appointments_date_status
ON appointments(appointment_date, status);
```

The index contains two columns:

- `appointment_date`
- `status`

A composite index was selected because the test query uses both columns as filtering conditions.

## 5. Execution Plan After Indexing

The same EXPLAIN query was executed again after creating the index.

Results:

| Property | Result |
|---|---|
| Access type (`type`) | range |
| Possible keys | idx_appointments_date_status |
| Selected key (`key`) | idx_appointments_date_status |
| Key length (`key_len`) | 7 |
| Reference (`ref`) | NULL |
| Estimated rows | 36 |
| Extra | Using index condition |

### Analysis

MySQL naturally selected the newly created composite index.

The access type changed from `ALL` to `range`, indicating that MySQL used an index range scan for the appointment date condition.

The estimated number of rows examined decreased from 1,000 to 36, representing an estimated reduction of approximately 96.4%.

The `Using index condition` output indicates that MySQL applied Index Condition Pushdown.

## 6. Conclusion

The experiment demonstrated that the composite index improved the query execution plan. MySQL selected the index naturally and estimated that fewer records would need to be examined.

The results support the use of appropriate composite indexes for queries involving multiple filtering conditions.