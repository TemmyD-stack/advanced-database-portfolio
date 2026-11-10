# Actual Query Execution-Time and Performance Analysis

## 1. Introduction

This experiment evaluates the execution time of SQL queries in the Hospital Management Information System (HMIS).

The objective is to compare query execution with and without indexes and examine how indexing affects data retrieval performance.

The experiment was conducted using MySQL through phpMyAdmin, with 100 patient records in the `patients` table.

## 2. Test Query

The same SQL query was executed under two conditions:

- Without using indexes.
- Using the available indexes.

### Query Without Indexes

```sql
SELECT *
FROM patients
IGNORE INDEX (idx_patients_last_name, idx_patients_lastname_gender)
WHERE last_name = 'Adebayo';
```

### Query With Indexes

```sql
SELECT *
FROM patients
WHERE last_name = 'Adebayo';
```

Both queries returned 11 records.

## 3. Execution-Time Measurements

Each query was executed four times to observe variations in execution time.

### Results Without Indexes

| Trial | Execution Time |
|---|---:|
| 1 | 0.0011 seconds |
| 2 | 0.0008 seconds |
| 3 | 0.0009 seconds |
| 4 | 0.0007 seconds |
| **Average** | **0.000875 seconds** |
| **Median** | **0.00085 seconds** |

### Results With Indexes

| Trial | Execution Time |
|---|---:|
| 1 | 0.0585 seconds |
| 2 | 0.0006 seconds |
| 3 | 0.0006 seconds |
| 4 | 0.0008 seconds |
| **Average** | **0.015125 seconds** |
| **Median** | **0.0007 seconds** |

## 4. Performance Comparison

| Measurement | Without Index | With Index |
|---|---:|---:|
| Average execution time | 0.000875 s | 0.015125 s |
| Median execution time | 0.00085 s | 0.0007 s |
| Records returned | 11 | 11 |

### Analysis

The measurements show variations in query execution time.

The indexed query recorded an unusually high execution time of 0.0585 seconds during its first trial. This increased its overall average execution time significantly.

However, the median execution time was 0.0007 seconds for the indexed query compared with 0.00085 seconds for the query without indexes.

This represents a small difference in favour of the indexed query in the median measurements.

The results suggest that indexing can influence query performance, but the improvement observed in this experiment is not conclusive.

## 5. Interpretation of Results

The experiment demonstrates that execution time can vary between repeated queries.

Several factors may influence the measurements, including:

- Database caching.
- Query execution overhead.
- Background system activity.
- The relatively small size of the dataset.

Since the patients table contains only 100 records, a full table scan is inexpensive. Therefore, the benefit of indexing may be more noticeable when working with larger datasets.

## 6. Conclusion

The experiment compared the execution time of a patient search query with and without indexes.

Although the indexed query had a lower median execution time, its average was affected by an unusually high first measurement.

Therefore, the experiment does not establish a consistent or significant execution-time improvement.

Nevertheless, the earlier EXPLAIN experiments demonstrated that indexing changed the query execution plan from a full table scan to an index lookup.

This confirms the importance of examining both query execution plans and actual execution times when evaluating database optimisation.

## 7. Limitations

The experiment was conducted using a relatively small dataset of 100 patient records and only four timing trials for each condition.

The execution times were obtained from phpMyAdmin, and small timing differences may be affected by caching and system overhead.

Further testing with a larger dataset and additional trials would provide stronger evidence of the performance impact of indexing.