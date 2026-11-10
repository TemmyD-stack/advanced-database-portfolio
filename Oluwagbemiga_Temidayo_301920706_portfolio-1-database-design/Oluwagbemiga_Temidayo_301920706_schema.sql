
-- ============================================
-- HOSPITAL MANAGEMENT INFORMATION SYSTEM
-- Database Schema
-- ============================================

CREATE DATABASE IF NOT EXISTS hospital_management;

USE hospital_management;


-- ============================================
-- 1. PATIENTS TABLE
-- ============================================

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(20) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- ============================================
-- 2. DOCTORS TABLE
-- ============================================

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- ============================================
-- 3. APPOINTMENTS TABLE
-- ============================================

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255),
    status ENUM('scheduled', 'completed', 'cancelled')
        DEFAULT 'scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    CONSTRAINT fk_appointment_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
) ENGINE=InnoDB;


-- ============================================
-- 4. DIAGNOSES TABLE
-- Revised structure
-- ============================================

CREATE TABLE diagnoses (
    diagnosis_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    diagnosis_name VARCHAR(150) NOT NULL,
    description TEXT,
    treatment TEXT,
    diagnosis_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_diagnosis_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)
) ENGINE=InnoDB;


-- ============================================
-- 5. PRESCRIPTIONS TABLE
-- ============================================

CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    diagnosis_id INT NOT NULL,
    medication_name VARCHAR(150) NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    frequency VARCHAR(100) NOT NULL,
    duration VARCHAR(100),
    instructions TEXT,
    prescribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_prescription_diagnosis
        FOREIGN KEY (diagnosis_id)
        REFERENCES diagnoses(diagnosis_id)
) ENGINE=InnoDB;


-- ============================================
-- 6. LABORATORY TESTS TABLE
-- ============================================

CREATE TABLE laboratory_tests (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    test_name VARCHAR(150) NOT NULL,
    test_description TEXT,
    test_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('requested', 'in_progress', 'completed')
        DEFAULT 'requested',

    CONSTRAINT fk_test_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    CONSTRAINT fk_test_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
) ENGINE=InnoDB;


-- ============================================
-- 7. LABORATORY RESULTS TABLE
-- ============================================

CREATE TABLE laboratory_results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    test_id INT NOT NULL UNIQUE,
    result_details TEXT NOT NULL,
    findings TEXT,
    result_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_result_test
        FOREIGN KEY (test_id)
        REFERENCES laboratory_tests(test_id)
) ENGINE=InnoDB;


-- ============================================
-- END OF DATABASE SCHEMA
-- ============================================
