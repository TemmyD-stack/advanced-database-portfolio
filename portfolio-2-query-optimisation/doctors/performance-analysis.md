## Experiment 2: Doctors Table Performance Test

### Objective

To compare the execution times of a query searching for doctors by specialization, both with and without the index on `doctors.specialization`.

### Test Queries

**Query without the index**

```sql
SELECT *
FROM doctors
IGNORE INDEX (idx_doctors_specialization)
WHERE specialization = 'Cardiology';
```

**Query with the index**

```sql
SELECT *
FROM doctors
WHERE specialization = 'Cardiology';
```

Both queries returned the same three records.

### Execution Time Results

Each query was executed four times.

| Trial | Without Index (seconds) | With Index (seconds) |
|---|---:|---:|
| 1 | 0.0005 | 0.0247 |
| 2 | 0.0003 | 0.0004 |
| 3 | 0.0004 | 0.0005 |
| 4 | 0.0004 | 0.0004 |
| **Mean** | **0.0004** | **0.0065** |
| **Median** | **0.0004** | **0.00045** |

### Analysis

The indexed query produced one unusually high execution time of 0.0247 seconds during the first trial. The remaining three indexed trials ranged from 0.0004 to 0.0005 seconds.

The median execution times were very close: 0.00045 seconds with the index and 0.0004 seconds without the index.

This indicates that indexing did not produce a meaningful measured execution-time improvement in this experiment. The relatively small size of the doctors table (25 records), caching, and query execution overhead may have influenced the results.

However, the EXPLAIN results demonstrated a better execution plan after indexing, with the estimated rows examined decreasing from 25 to 3.

### Conclusion

The experiment shows that indexing can improve the database execution plan even when a noticeable reduction in execution time cannot be demonstrated on a small dataset.

The results also highlight the importance of evaluating both execution plans and actual query timings when assessing database performance.