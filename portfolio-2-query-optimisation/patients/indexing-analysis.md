# Indexing and Query Performance Analysis

## 1. Introduction

Database indexes are used to improve the efficiency of data retrieval. They help MySQL locate records without necessarily scanning every row in a table.

This exercise examines how single-column and composite indexes affect query execution plans in the Hospital Management Information System (HMIS).

The experiments were conducted using the `hospital_management` database in MySQL through phpMyAdmin.

## 2. Experiment One: Single-Column Index

### Objective

To examine how creating an index on the `last_name` column affects a query that searches for patients by their last name.

### Query Before Indexing

```sql
EXPLAIN
SELECT *
FROM patients
WHERE last_name = 'Adebayo';
```

### Initial Execution Plan

| Property       | Result |
| -------------- | ------ |
| Access type    | ALL    |
| Selected index | NULL   |
| Estimated rows | 100    |

### Analysis

Before creating the index, MySQL performed a full table scan (`ALL`). This means it estimated that all 100 patient records would need to be examined to find matching records.

No index was selected for the query.

### Creating the Index

```sql
CREATE INDEX idx_patients_last_name
ON patients(last_name);
```

### Query After Indexing

```sql
EXPLAIN
SELECT *
FROM patients
WHERE last_name = 'Adebayo';
```

### Execution Plan After Indexing

| Property       | Result                 |
| -------------- | ---------------------- |
| Access type    | ref                    |
| Selected index | idx_patients_last_name |
| Key length     | 202                    |
| Estimated rows | 11                     |

### Analysis

After creating the single-column index, MySQL changed the access type from `ALL` to `ref` and selected `idx_patients_last_name`.

The estimated number of rows examined decreased from 100 to 11. This indicates that the index helped MySQL narrow down the records relevant to the search instead of scanning the entire table.

### Conclusion

The experiment demonstrates that a single-column index can improve the query execution plan when searching using an indexed column.

## 3. Experiment Two: Composite Index

### Objective

To investigate how a composite index improves the execution plan of a query that uses multiple search conditions.

### Query Before Creating the Composite Index

```sql
EXPLAIN
SELECT *
FROM patients
WHERE last_name = 'Adebayo'
AND gender = 'Female';
```

### Initial Execution Plan

| Property       | Result                             |
| -------------- | ---------------------------------- |
| Access type    | ref                                |
| Selected index | idx_patients_last_name             |
| Key length     | 202                                |
| Estimated rows | 11                                 |
| Extra          | Using index condition; Using where |

### Analysis

Before creating the composite index, MySQL used the existing single-column index on `last_name`.

The `gender` condition was also evaluated to identify records matching both conditions.

### Creating the Composite Index

```sql
CREATE INDEX idx_patients_lastname_gender
ON patients (last_name, gender);
```

### Query After Creating the Composite Index

```sql
EXPLAIN
SELECT *
FROM patients
WHERE last_name = 'Adebayo'
AND gender = 'Female';
```

### Natural Execution Plan After Indexing

| Property       | Result                       |
| -------------- | ---------------------------- |
| Access type    | ref                          |
| Selected index | idx_patients_lastname_gender |
| Key length     | 284                          |
| Reference      | const, const                 |
| Estimated rows | 10                           |
| Extra          | Using index condition        |

### Analysis

After creating the composite index, MySQL's query optimiser naturally selected `idx_patients_lastname_gender` without requiring `FORCE INDEX`.

The `const, const` reference indicates that both search conditions are used in the index lookup.

The estimated number of rows decreased from 11 to 10 compared with the single-column index execution plan.

This demonstrates that a composite index can be useful when queries frequently filter records using multiple columns.

### Conclusion

The experiment shows that MySQL's query optimiser recognised and selected the composite index for the query. This confirms that the composite index was suitable for the search conditions.

However, the small reduction in estimated rows does not independently establish a significant improvement in actual execution time. Additional timing measurements would be required to evaluate the real performance difference.

## 4. Comparison of Indexing Experiments

| Experiment                                    | Index Used                   | Access Type | Estimated Rows |
| --------------------------------------------- | ---------------------------- | ----------- | -------------: |
| Before single-column indexing                 | None                         | ALL         |            100 |
| After single-column indexing                  | idx_patients_last_name       | ref         |             11 |
| Multiple conditions using single-column index | idx_patients_last_name       | ref         |             11 |
| Multiple conditions using composite index     | idx_patients_lastname_gender | ref         |             10 |

## 5. Overall Findings

The indexing experiments produced the following observations:

1. Without an appropriate index, MySQL performed a full table scan when searching for patients by last name.
2. Creating a single-column index changed the access type from `ALL` to `ref` and reduced the estimated rows from 100 to 11.
3. Creating a composite index allowed MySQL to use both `last_name` and `gender` in the index lookup.
4. MySQL's optimiser naturally selected the composite index without requiring an index hint.
5. The experiments demonstrate changes in query execution plans, but actual execution-time measurements are still needed to establish performance improvements.

## 6. Limitations

The experiments were conducted using a dataset containing 100 patient records. Although the execution plans demonstrate how indexes influence query processing, a larger dataset would provide a better environment for evaluating performance at scale.

Furthermore, the `rows` value reported by `EXPLAIN` represents an estimate by the MySQL optimiser, not necessarily the exact number of records examined during execution.

