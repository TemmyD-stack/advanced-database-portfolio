# Appointments Query Analysis

## 1. Introduction

This experiment evaluates the performance of queries on the HMIS appointments table. The objective is to examine how indexing can improve the retrieval of appointments based on appointment date and status.

## 2. Test Query

The query retrieves scheduled appointments within October 2026.

```sql
SELECT *
FROM appointments
WHERE appointment_date >= '2026-10-01 00:00:00'
  AND appointment_date < '2026-11-01 00:00:00'
  AND status = 'scheduled';
```

## 3. Initial Query Performance

Before creating an index, the query execution plan returned:

| Property | Result |
|---|---|
| Access type | ALL |
| Possible keys | NULL |
| Selected key | NULL |
| Estimated rows | 1,000 |
| Extra | Using where |

### Analysis

MySQL performed a full table scan because no suitable index was available for the query conditions. The execution plan estimated that all 1,000 appointment records could be examined.

## 4. Execution Time Comparison

The query was executed four times without the index and four times with the index.

| Trial | Without Index (seconds) | With Index (seconds) |
|---|---:|---:|
| 1 | 0.0040 | 0.0008 |
| 2 | 0.0028 | 0.0009 |
| 3 | 0.0039 | 0.0006 |
| 4 | 0.0015 | 0.0006 |
| **Mean** | **0.00305** | **0.000725** |
| **Median** | **0.00335** | **0.0007** |

Both queries returned the same nine scheduled appointments.

### Analysis

The indexed query recorded lower execution times in all four trials.

The median execution time decreased from 0.00335 seconds without the index to 0.0007 seconds with the index.

This indicates an improvement in the observed query execution time. However, the appointments table contains only 1,000 records, and factors such as caching and database overhead may influence the measurements.

## 5. Conclusion

The experiment demonstrates that indexing can improve query execution for searches involving appointment dates and status. The execution plan and timing measurements both showed improvements after the composite index was introduced.

Further testing with larger datasets would be useful to evaluate how the improvement scales.