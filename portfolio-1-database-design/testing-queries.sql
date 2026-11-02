
-- =====================================================
-- HOSPITAL MANAGEMENT INFORMATION SYSTEM (HMIS)
-- PORTFOLIO 1: DATABASE DESIGN AND MODELLING
-- SQL DATABASE TESTING QUERIES
-- Database: hospital_management
-- =====================================================

USE hospital_management;


-- =====================================================
-- 1. BASIC SELECT QUERIES
-- Retrieve all records from the Patients table
-- =====================================================

SELECT * FROM patients;


-- Retrieve all records from the Doctors table

SELECT * FROM doctors;


-- =====================================================
-- 2. FILTERING QUERIES
-- Retrieve patients whose gender is Female
-- =====================================================

SELECT
    first_name,
    last_name,
    gender
FROM patients
WHERE gender = 'Female';


-- =====================================================
-- 3. SORTING QUERIES
-- Arrange patients by date of birth
-- Oldest patients appear first
-- =====================================================

SELECT
    first_name,
    last_name,
    date_of_birth
FROM patients
ORDER BY date_of_birth ASC;


-- =====================================================
-- 4. AGGREGATE FUNCTIONS
-- Count the total number of registered patients
-- =====================================================

SELECT COUNT(*) AS total_patients
FROM patients;


-- Count appointments grouped by their status

SELECT
    status,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY status;


-- =====================================================
-- 5. INNER JOIN OPERATIONS
-- Retrieve appointments with patient and doctor details
-- =====================================================

SELECT
    appointments.appointment_id,
    patients.first_name AS patient_first_name,
    patients.last_name AS patient_last_name,
    doctors.first_name AS doctor_first_name,
    doctors.last_name AS doctor_last_name,
    doctors.specialization,
    appointments.appointment_date,
    appointments.reason,
    appointments.status
FROM appointments
INNER JOIN patients
    ON appointments.patient_id = patients.patient_id
INNER JOIN doctors
    ON appointments.doctor_id = doctors.doctor_id;


-- =====================================================
-- Retrieve diagnoses with patient and doctor details
-- using the appointment relationship
-- =====================================================

SELECT
    diagnoses.diagnosis_id,
    patients.first_name AS patient_first_name,
    patients.last_name AS patient_last_name,
    doctors.first_name AS doctor_first_name,
    doctors.last_name AS doctor_last_name,
    diagnoses.diagnosis_name,
    diagnoses.description,
    diagnoses.treatment,
    diagnoses.diagnosis_date
FROM diagnoses
INNER JOIN appointments
    ON diagnoses.appointment_id = appointments.appointment_id
INNER JOIN patients
    ON appointments.patient_id = patients.patient_id
INNER JOIN doctors
    ON appointments.doctor_id = doctors.doctor_id;


-- =====================================================
-- 6. LEFT JOIN OPERATIONS
-- Retrieve all laboratory tests, including tests
-- that do not yet have recorded results
-- =====================================================

SELECT
    laboratory_tests.test_id,
    laboratory_tests.test_name,
    laboratory_tests.status,
    laboratory_results.result_details,
    laboratory_results.findings,
    laboratory_results.result_date
FROM laboratory_tests
LEFT JOIN laboratory_results
    ON laboratory_tests.test_id = laboratory_results.test_id;


-- =====================================================
-- Identify patients who have no laboratory results
-- This includes patients without tests and patients
-- whose tests have no recorded results
-- =====================================================

SELECT DISTINCT
    patients.patient_id,
    patients.first_name,
    patients.last_name
FROM patients
LEFT JOIN laboratory_tests
    ON patients.patient_id = laboratory_tests.patient_id
LEFT JOIN laboratory_results
    ON laboratory_tests.test_id = laboratory_results.test_id
WHERE laboratory_results.result_id IS NULL;


-- =====================================================
-- END OF PORTFOLIO 1 DATABASE TESTING QUERIES
-- =====================================================
