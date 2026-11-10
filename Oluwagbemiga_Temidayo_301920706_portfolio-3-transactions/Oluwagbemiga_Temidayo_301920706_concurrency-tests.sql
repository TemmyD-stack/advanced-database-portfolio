
-- =====================================================
-- PORTFOLIO 3: CONCURRENCY CONTROL
-- Database: hospital_management
-- Technique: Row-Level Locking
-- Requires TWO independent database sessions.
-- =====================================================

USE hospital_management;

-- SESSION A
START TRANSACTION;

-- Acquire an exclusive lock on the selected patient row.
SELECT patient_id, first_name, last_name, address
FROM patients
WHERE patient_id = 101
FOR UPDATE;

-- Keep this transaction open.


-- SESSION B
-- Execute in the second independent connection.

USE hospital_management;

START TRANSACTION;

-- This update must wait while Session A holds the lock.
UPDATE patients
SET address = 'Updated by Session B'
WHERE patient_id = 101;

-- In our experiment, this returned:
-- ERROR 1205: Lock wait timeout exceeded.


-- SESSION B
-- Clean up after the failed update.
ROLLBACK;


-- SESSION A
-- Release the row-level lock.
COMMIT;


-- SESSION B
-- Verify the previously committed address.
SELECT patient_id, first_name, last_name, address
FROM patients
WHERE patient_id = 101;
