
-- =====================================================
-- PORTFOLIO 3: TRANSACTIONS AND CONCURRENCY
-- Database: hospital_management
-- Experiment 1: COMMIT
-- =====================================================

USE hospital_management;

-- Register a fictional patient within a transaction
START TRANSACTION;

INSERT INTO patients (
    first_name,
    last_name,
    email
)
VALUES (
    'Olivia',
    'James',
    'olivia.james@hmis.test'
);

-- Permanently save the transaction
COMMIT;

-- Verify the committed patient record
SELECT *
FROM patients
WHERE patient_id = 101;


-- =====================================================
-- Experiment 2: ROLLBACK
-- =====================================================

START TRANSACTION;

-- Insert a temporary patient record
INSERT INTO patients (
    first_name,
    last_name,
    date_of_birth,
    gender,
    email
)
VALUES (
    'Daniel',
    'Williams',
    '1995-06-15',
    'Male',
    'daniel.williams.rollback@hmis.test'
);

-- Inspect the temporary record before rollback
SELECT *
FROM patients
WHERE email = 'daniel.williams.rollback@hmis.test';

-- Reverse the uncommitted insertion
ROLLBACK;

-- Verify that the record no longer exists
SELECT *
FROM patients
WHERE email = 'daniel.williams.rollback@hmis.test';
