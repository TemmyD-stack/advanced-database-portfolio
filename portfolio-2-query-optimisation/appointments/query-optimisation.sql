
-- =====================================================
-- HMIS PORTFOLIO 2
-- EXPERIMENT: APPOINTMENTS QUERY OPTIMISATION
-- =====================================================

USE hospital_management;


-- 1. BASELINE EXECUTION PLAN
-- Check query performance before indexing

EXPLAIN
SELECT *
FROM appointments
WHERE appointment_date >= '2026-10-01 00:00:00'
  AND appointment_date < '2026-11-01 00:00:00'
  AND status = 'scheduled';


-- 2. CREATE COMPOSITE INDEX

CREATE INDEX idx_appointments_date_status
ON appointments(appointment_date, status);


-- 3. EXECUTION PLAN AFTER INDEXING

EXPLAIN
SELECT *
FROM appointments
WHERE appointment_date >= '2026-10-01 00:00:00'
  AND appointment_date < '2026-11-01 00:00:00'
  AND status = 'scheduled';


-- 4. PERFORMANCE TEST WITHOUT INDEX

SELECT *
FROM appointments
IGNORE INDEX (idx_appointments_date_status)
WHERE appointment_date >= '2026-10-01 00:00:00'
  AND appointment_date < '2026-11-01 00:00:00'
  AND status = 'scheduled';


-- 5. PERFORMANCE TEST WITH INDEX

SELECT *
FROM appointments
WHERE appointment_date >= '2026-10-01 00:00:00'
  AND appointment_date < '2026-11-01 00:00:00'
  AND status = 'scheduled';


-- 6. VIEW INDEXES ON APPOINTMENTS

SHOW INDEX FROM appointments;
