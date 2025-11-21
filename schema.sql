-- ELIGIFY Database Schema (Refactored for Normalization)
-- Focus: Removing derived fields and normalizing repeating groups.

-- Drop database if it exists and create a new one
DROP DATABASE IF EXISTS eligify_db;
CREATE DATABASE eligify_db;
USE eligify_db;

-- -----------------------------------------------------
-- Table: Exam (Core Exam Information)
-- -----------------------------------------------------
CREATE TABLE Exam (
    exam_id INT PRIMARY KEY,
    exam_name VARCHAR(100) NOT NULL,
    max_attempts INT,
    conducting_body VARCHAR(100),
    exam_level VARCHAR(100), -- E.g., National, State
    exam_mode VARCHAR(100), -- E.g., Online, Offline
    website VARCHAR(200),
    exam_month INT,
    exam_type VARCHAR(100), -- E.g., Engineering, Medical
    fee_gen_ews INT,
    total_duration_mins INT
);

-- -----------------------------------------------------
-- Table: ExamSubject (Normalized 1:Many relationship)
-- Replaces the denormalized 'Subjects' table.
-- -----------------------------------------------------
CREATE TABLE ExamSubject (
    exam_subject_id INT PRIMARY KEY AUTO_INCREMENT,
    exam_id INT NOT NULL,
    subject_name VARCHAR(200) NOT NULL,
    -- Ensure an exam doesn't have the same subject listed twice
    UNIQUE KEY uk_exam_subject (exam_id, subject_name),
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table: Eligibility (Exam-specific criteria)
-- This table remains as a 1:1 extension of Exam to keep concerns separate.
-- -----------------------------------------------------
CREATE TABLE Eligibility (
    exam_id INT PRIMARY KEY,
    min_age INT,
    max_age INT,
    min_10_percent INT,
    min_12_percent INT,
    min_ug_cgpa FLOAT,
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table: Reservation (Exam-specific reservation quotas)
-- -----------------------------------------------------
CREATE TABLE Reservation (
    exam_id INT PRIMARY KEY,
    ews_percent INT,
    obc_ncl_percent INT,
    sc_percent INT,
    st_percent INT,
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table: Documents (Exam-specific required documents)
-- -----------------------------------------------------
CREATE TABLE Documents (
    exam_id INT PRIMARY KEY,
    caste_certificate BOOLEAN,
    domicile BOOLEAN,
    birth_certificate BOOLEAN,
    photo BOOLEAN,
    signature BOOLEAN,
    aadhar BOOLEAN,
    ug_degree BOOLEAN,
    pg_degree BOOLEAN,
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table: Candidate (The user registration table)
-- 'age' derived field removed.
-- -----------------------------------------------------
CREATE TABLE Candidate (
    candidate_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    qualification VARCHAR(100),
    category VARCHAR(50),
    p_10 FLOAT, -- 10th Percentage
    p_12 FLOAT, -- 12th Percentage
    course VARCHAR(100),
    ug_cgpa FLOAT,
    pg_cgpa FLOAT
);