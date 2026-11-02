-- =====================================================
-- HOSPITAL MANAGEMENT INFORMATION SYSTEM (HMIS)
-- PORTFOLIO 2: QUERY PROCESSING AND OPTIMISATION
-- File: query-optimisation.sql
-- Database: hospital_management
-- =====================================================

USE hospital_management;


-- =====================================================
-- 1. INITIAL QUERY PERFORMANCE TEST
-- Search for patients by last name before indexing.
-- =====================================================

EXPLAIN
SELECT *
FROM patients
WHERE last_name = 'Adebayo';


-- =====================================================
-- 2. SINGLE-COLUMN INDEX
-- Create an index on the last_name column.
-- =====================================================

CREATE INDEX idx_patients_last_name
ON patients(last_name);


-- =====================================================
-- 3. QUERY EXECUTION AFTER SINGLE-COLUMN INDEXING
-- Check whether MySQL uses the new index.
-- =====================================================

EXPLAIN
SELECT *
FROM patients
WHERE last_name = 'Adebayo';


-- =====================================================
-- 4. QUERY WITH MULTIPLE CONDITIONS
-- Search for patients by last name and gender.
-- Initially, this uses the single-column index.
-- =====================================================

EXPLAIN
SELECT *
FROM patients
WHERE last_name = 'Adebayo'
AND gender = 'Female';


-- =====================================================
-- 5. COMPOSITE INDEX
-- Create an index using last_name and gender.
-- =====================================================

CREATE INDEX idx_patients_lastname_gender
ON patients (last_name, gender);


-- =====================================================
-- 6. QUERY EXECUTION AFTER COMPOSITE INDEXING
-- Allow MySQL to select the index naturally.
-- =====================================================

EXPLAIN
SELECT *
FROM patients
WHERE last_name = 'Adebayo'
AND gender = 'Female';


-- =====================================================
-- 7. VERIFY CREATED INDEXES
-- Display the indexes available on the patients table.
-- =====================================================

SHOW INDEX FROM patients;


-- =====================================================
-- END OF CURRENT QUERY OPTIMISATION EXERCISES
-- Actual execution-time measurements will be added
-- in a later section.
-- =====================================================