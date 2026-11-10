
-- =====================================================
-- PORTFOLIO 3: TRANSACTION ISOLATION
-- Database: hospital_management
-- Isolation Level: READ COMMITTED
-- Requires TWO independent database sessions.
-- =====================================================

USE hospital_management;

-- SESSION A
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

UPDATE patients
SET address = 'Isolation Test Address'
WHERE patient_id = 101;

-- DO NOT COMMIT YET.


-- SESSION B
-- Run these commands in a separate connection.

USE hospital_management;

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT patient_id, first_name, last_name, address
FROM patients
WHERE patient_id = 101;

-- Expected before Session A commits:
-- The previous committed address (NULL).


-- SESSION A
COMMIT;


-- SESSION B
-- Run this SELECT again in the same Session B transaction.

SELECT patient_id, first_name, last_name, address
FROM patients
WHERE patient_id = 101;

-- Expected result:
-- Isolation Test Address

-- End Session B's transaction.
COMMIT;
