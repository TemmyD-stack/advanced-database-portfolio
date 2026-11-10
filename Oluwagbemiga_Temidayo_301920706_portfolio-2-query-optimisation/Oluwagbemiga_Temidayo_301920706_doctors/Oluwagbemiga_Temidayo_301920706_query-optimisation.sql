
-- =====================================================
-- EXPERIMENT 3: DOCTORS TABLE INDEXING
-- Objective: Optimise searches by doctor specialization
-- =====================================================

USE hospital_management;

-- 1. Check the execution plan before indexing
EXPLAIN
SELECT *
FROM doctors
WHERE specialization = 'Cardiology';


-- 2. Create an index on the specialization column
CREATE INDEX idx_doctors_specialization
ON doctors(specialization);


-- 3. Check the execution plan after indexing
EXPLAIN
SELECT *
FROM doctors
WHERE specialization = 'Cardiology';


-- 4. Performance test without using the index
SELECT *
FROM doctors
IGNORE INDEX (idx_doctors_specialization)
WHERE specialization = 'Cardiology';


-- 5. Performance test using the index
SELECT *
FROM doctors
WHERE specialization = 'Cardiology';


-- 6. Display the indexes created on the doctors table
SHOW INDEX FROM doctors;
