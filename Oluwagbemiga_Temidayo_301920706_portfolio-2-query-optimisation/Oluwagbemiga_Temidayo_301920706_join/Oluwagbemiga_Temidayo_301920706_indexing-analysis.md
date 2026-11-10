# JOIN Indexing Analysis

## 1. Introduction

JOIN operations often rely on indexes to locate related records efficiently. This experiment examines how existing primary-key, foreign-key, and composite indexes support JOIN operations in the HMIS database.

## 2. Existing Indexes

The three tables involved in the experiment contain the following relevant indexes:

| Table | Column | Index |
|---|---|---|
| appointments | patient_id | fk_appointment_patient |
| appointments | doctor_id | fk_appointment_doctor |
| appointments | appointment_date, status | idx_appointments_date_status |
| patients | patient_id | PRIMARY |
| doctors | doctor_id | PRIMARY |

These indexes were already available before the JOIN experiment.

## 3. Original JOIN Execution Plan

The original three-table JOIN produced the following results:

| Table | Access type | Selected index | Estimated rows |
|---|---|---|---:|
| doctors | ALL | None | 25 |
| appointments | ref | fk_appointment_doctor | 20 |
| patients | eq_ref | PRIMARY | 1 |

### Analysis

MySQL began with the doctors table and scanned its 25 records. It then used the foreign-key index on appointments to locate related appointments.

Finally, it used the patients primary key to retrieve the corresponding patient records.

The full table scan on doctors was reasonable because the table contained only 25 records.

## 4. Filtered JOIN Execution Plan

After introducing date and status conditions, the execution plan changed:

| Table | Access type | Selected index | Estimated rows |
|---|---|---|---:|
| appointments | range | idx_appointments_date_status | 36 |
| doctors | eq_ref | PRIMARY | 1 |
| patients | eq_ref | PRIMARY | 1 |

### Analysis

MySQL changed the join order and started with appointments.

The composite index on appointment_date and status was selected naturally. The range access type indicates that MySQL used an index range scan for the date condition.

The doctors and patients tables were then accessed through their primary keys using `eq_ref`.

## 5. Indexing Decision

No additional indexes were created during this experiment.

The existing indexes already supported the JOIN operations:
- The appointments foreign-key indexes supported relationships with patients and doctors.
- The patients and doctors primary keys supported efficient record lookups.
- The composite appointments index supported the date and status filtering conditions.

Creating additional indexes without evidence of a performance problem could introduce unnecessary storage and maintenance overhead.

## 6. Conclusion

The experiment demonstrated that existing indexes can support multiple query operations, including JOINs.

The composite appointments index created in the earlier appointments experiment was also useful in the filtered JOIN query.

This highlights the importance of evaluating existing indexes before introducing additional ones.