
-- =====================================================
-- HMIS PORTFOLIO 2
-- EXPERIMENT 5: JOIN QUERY OPTIMISATION
-- =====================================================

USE hospital_management;


-- 1. ORIGINAL JOIN EXECUTION PLAN

EXPLAIN
SELECT
    a.appointment_id,
    a.appointment_date,
    a.status,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    d.specialization
FROM appointments a
INNER JOIN patients p
    ON a.patient_id = p.patient_id
INNER JOIN doctors d
    ON a.doctor_id = d.doctor_id;


-- 2. ORIGINAL JOIN QUERY

SELECT
    a.appointment_id,
    a.appointment_date,
    a.status,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    d.specialization
FROM appointments a
INNER JOIN patients p
    ON a.patient_id = p.patient_id
INNER JOIN doctors d
    ON a.doctor_id = d.doctor_id;


-- 3. FILTERED JOIN EXECUTION PLAN

EXPLAIN
SELECT
    a.appointment_id,
    a.appointment_date,
    a.status,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    d.specialization
FROM appointments a
INNER JOIN patients p
    ON a.patient_id = p.patient_id
INNER JOIN doctors d
    ON a.doctor_id = d.doctor_id
WHERE a.appointment_date >= '2026-10-01 00:00:00'
  AND a.appointment_date < '2026-11-01 00:00:00'
  AND a.status = 'scheduled';


-- 4. FILTERED JOIN QUERY

SELECT
    a.appointment_id,
    a.appointment_date,
    a.status,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    d.specialization
FROM appointments a
INNER JOIN patients p
    ON a.patient_id = p.patient_id
INNER JOIN doctors d
    ON a.doctor_id = d.doctor_id
WHERE a.appointment_date >= '2026-10-01 00:00:00'
  AND a.appointment_date < '2026-11-01 00:00:00'
  AND a.status = 'scheduled';


-- 5. REVIEW EXISTING INDEXES

SHOW INDEX FROM appointments;

SHOW INDEX FROM patients;

SHOW INDEX FROM doctors;
