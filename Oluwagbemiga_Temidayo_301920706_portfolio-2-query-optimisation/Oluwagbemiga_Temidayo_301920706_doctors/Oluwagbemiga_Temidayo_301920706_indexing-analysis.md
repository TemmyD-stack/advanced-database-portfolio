## Experiment 3: Indexing the Doctors Table

### Objective
To examine whether creating an index on the `specialization` column improves query execution when searching for doctors by their medical specialization.

### Test Query

```sql
EXPLAIN
SELECT *
FROM doctors
WHERE specialization = 'Cardiology';
```

### Before Indexing

The initial execution plan returned:

| Property | Result |
|---|---|
| Access type (`type`) | ALL |
| Possible keys | NULL |
| Selected key (`key`) | NULL |
| Estimated rows | 25 |
| Extra | Using where |

**Analysis:** MySQL performed a full table scan because no index was available for the specialization column. The execution plan estimated that all 25 doctor records would be examined.

### Creating the Index

```sql
CREATE INDEX idx_doctors_specialization
ON doctors(specialization);
```

### After Indexing

The same EXPLAIN query was executed again without forcing the index.

The execution plan returned:

| Property | Result |
|---|---|
| Access type (`type`) | ref |
| Possible keys | idx_doctors_specialization |
| Selected key (`key`) | idx_doctors_specialization |
| Key length (`key_len`) | 402 |
| Reference (`ref`) | const |
| Estimated rows | 3 |
| Extra | Using index condition |

**Analysis:** MySQL naturally selected the newly created index. The access type changed from `ALL` to `ref`, and the estimated number of rows examined decreased from 25 to 3.

This represents an estimated reduction of approximately 88% in rows examined.

### Conclusion

The indexing experiment demonstrated that an index on `doctors.specialization` improved the query execution plan. MySQL was able to use the index to locate doctors with the specified specialization instead of scanning the entire table.

However, the actual execution-time measurements are considered separately in `performance-analysis.md`.