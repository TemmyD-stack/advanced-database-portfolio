# Doctors Query Analysis

## 1. Objective

The objective of this experiment was to examine how MySQL executes a query that retrieves doctors based on their medical specialization.

## 2. Test Query

```sql
EXPLAIN
SELECT *
FROM doctors
WHERE specialization = 'Cardiology';
```

## 3. Execution Plan Before Indexing

Before creating an index, the `EXPLAIN` statement returned the following observations:

- Access type: ALL
- Selected key: NULL
- Estimated rows: 25
- Extra: Using where

The access type `ALL` indicates that MySQL performed a full table scan to find doctors whose specialization was Cardiology.

## 4. Execution Plan After Indexing

An index named `idx_doctors_specialization` was created on the `specialization` column.

After indexing, the execution plan showed:

- Access type: ref
- Selected key: idx_doctors_specialization
- Estimated rows: 3
- Extra: Using index condition

The access type changed from `ALL` to `ref`, indicating that MySQL used the index to locate matching records.

## 5. Analysis

The estimated number of rows examined decreased from 25 to 3, representing an estimated reduction of 88%.

The index improved the query execution plan by allowing MySQL to locate doctors using their specialization rather than scanning the entire table.

The query returned three matching doctors in both cases, confirming that indexing did not change the query results.

## 6. Conclusion

Creating an index on the `specialization` column improved the execution plan for this query.

Although the execution plan showed a clear improvement, the doctors table contained only 25 records. Therefore, the measured execution-time differences were too small to establish a consistent performance improvement. Larger datasets would be useful for further testing.