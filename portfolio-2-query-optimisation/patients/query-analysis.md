# Query Performance Analysis

## 1. Introduction

Query performance analysis involves examining how a database executes SQL queries and identifying opportunities to improve efficiency.

This exercise uses the Hospital Management Information System (HMIS) to examine query execution plans in MySQL.

## 2. Initial Query Performance Test

### Test Query

```sql
EXPLAIN
SELECT *
FROM patients
WHERE last_name = 'Adebayo';
```

### Execution Plan Results

| Property | Result |
|---|---|
| Access type | ALL |
| Selected index | NULL |
| Estimated rows | 100 |

### Analysis

The execution plan shows that MySQL performs a full table scan when searching for a patient by last name.

The access type `ALL` indicates that the entire table is scanned, while `key = NULL` indicates that no index was selected.

MySQL estimates that it will examine all 100 patient records to find matching surnames.

Although this approach works with a small dataset, it may become inefficient as the database grows.

### Conclusion

The initial execution plan revealed an opportunity to optimise data retrieval using indexing. Further experiments were conducted to examine how single-column and composite indexes affect query execution.

The indexing experiments and their results are documented separately in `indexing-analysis.md`.