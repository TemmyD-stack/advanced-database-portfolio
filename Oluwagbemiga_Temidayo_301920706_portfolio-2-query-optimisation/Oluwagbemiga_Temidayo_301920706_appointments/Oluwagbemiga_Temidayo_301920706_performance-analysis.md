# Appointments Query Performance Analysis

## 1. Objective

The objective of this experiment was to compare the execution time of an appointments query before and after creating a composite index on the `appointment_date` and `status` columns.

## 2. Test Query

The query retrieves scheduled appointments within October 2026.

```sql
SELECT *
FROM appointments
WHERE appointment_date >= '2026-10-01 00:00:00'
  AND appointment_date < '2026-11-01 00:00:00'
  AND status = 'scheduled';
```

## 3. Performance Results

Both versions of the query returned 9 records.

### Unindexed Query

The index was ignored using `IGNORE INDEX` to simulate execution without the composite index.

| Trial | Execution Time (seconds) |
|---|---:|
| 1 | 0.0040 |
| 2 | 0.0028 |
| 3 | 0.0039 |
| 4 | 0.0015 |
| **Mean** | **0.00305** |
| **Median** | **0.00335** |

### Indexed Query

The query was executed using the composite index `idx_appointments_date_status`.

| Trial | Execution Time (seconds) |
|---|---:|
| 1 | 0.0008 |
| 2 | 0.0009 |
| 3 | 0.0006 |
| 4 | 0.0006 |
| **Mean** | **0.000725** |
| **Median** | **0.0007** |

## 4. Comparison and Analysis

The indexed query was faster in all four recorded trials.

The mean execution time decreased from 0.00305 seconds to 0.000725 seconds. This represents an approximate reduction of 76.2%.

The `EXPLAIN` analysis also showed that the estimated rows examined decreased from 1,000 before indexing to 36 after indexing.

The composite index allowed MySQL to use a range access strategy rather than performing a full table scan.

## 5. Conclusion

The composite index on `appointment_date` and `status` improved the query execution plan and produced faster measured execution times in this experiment.

However, the database contained only 1,000 appointment records. Results from a relatively small dataset may not represent performance at a much larger scale. Further testing with larger datasets would provide stronger evidence of the index's effectiveness.