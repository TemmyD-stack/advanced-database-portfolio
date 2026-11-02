# JOIN Performance Analysis

## 1. Introduction

This document evaluates the execution times of two JOIN queries involving the appointments, patients, and doctors tables.

The first query retrieves all appointment records, while the second retrieves only scheduled appointments within October 2026.

Each query was executed four times to observe execution-time variations.

## 2. Original JOIN Performance

The original JOIN query returned 1,000 records.

### Execution Time Results

| Trial | Execution time (seconds) |
|---|---:|
| 1 | 0.1138 |
| 2 | 0.0006 |
| 3 | 0.0008 |
| 4 | 0.0009 |
| **Mean** | **0.029025** |
| **Median** | **0.00085** |

### Analysis

The first execution recorded 0.1138 seconds, which was considerably higher than the remaining three measurements.

This may be associated with initial query execution overhead, caching, or other server-related factors.

The median execution time of 0.00085 seconds provides a more representative measure of the typical execution time across these trials.

## 3. Filtered JOIN Performance

The filtered JOIN query returned nine scheduled appointments within October 2026.

### Execution Time Results

| Trial | Execution time (seconds) |
|---|---:|
| 1 | 0.0008 |
| 2 | 0.0007 |
| 3 | 0.0010 |
| 4 | 0.0618 |
| **Mean** | **0.016075** |
| **Median** | **0.0009** |

### Analysis

The fourth execution recorded 0.0618 seconds, which was considerably higher than the other measurements.

The remaining three trials ranged from 0.0007 to 0.0010 seconds.

The median execution time was 0.0009 seconds, while the mean was influenced by the unusually high fourth measurement.

## 4. Overall Findings

The execution plans showed that MySQL used existing indexes to retrieve related records.

The filtered JOIN naturally selected the composite index on appointments and used primary-key lookups for the related doctors and patients.

Both queries demonstrated variations in execution time across repeated trials.

However, the original and filtered JOIN queries retrieve different numbers of records. Therefore, their execution times should not be interpreted as a direct before-and-after performance comparison.

## 5. Limitations

The measurements were collected using phpMyAdmin on a local MySQL environment.

Execution times may be affected by:
- Query caching and database buffer activity.
- Initial execution overhead.
- Background processes and server workload.
- The relatively small size of the dataset.

Further testing with larger datasets and controlled execution conditions would provide stronger evidence of performance differences.

## 6. Conclusion

The experiment demonstrated that JOIN performance depends on query conditions, table relationships, execution order, and available indexes.

MySQL successfully reused existing indexes to retrieve related HMIS records. The results also demonstrate why execution plans and repeated timing measurements should both be considered when evaluating database performance.