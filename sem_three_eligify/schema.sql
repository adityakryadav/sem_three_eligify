-- Drop database if exists and create a new one
DROP DATABASE IF EXISTS eligify_db;
CREATE DATABASE eligify_db;
USE eligify_db;

-- -----------------------------------------------------
-- Table: Exam (3NF)
-- -----------------------------------------------------
CREATE TABLE Exam (
    exam_id INT PRIMARY KEY,
    exam_name VARCHAR(100) NOT NULL,
    max_attempts INT,
    conducting_body VARCHAR(100),
    exam_level VARCHAR(100),
    exam_mode VARCHAR(100),
    website VARCHAR(200),
    exam_month INT,
    exam_type VARCHAR(100),
    fee_gen_ews INT,
    total_duration_mins INT
);

-- -----------------------------------------------------
-- Table: Exam_Subject (3NF)
-- -----------------------------------------------------
CREATE TABLE Exam_Subject (
    exam_id INT,
    subject_name VARCHAR(200) NOT NULL,
    PRIMARY KEY (exam_id, subject_name),
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Table: Eligibility (3NF)
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
-- Table: Reservation (3NF)
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
-- Table: Documents (3NF)
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
-- Table: Candidate (3NF - Transitive dependency removed)
-- -----------------------------------------------------
CREATE TABLE Candidate (
    candidate_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    qualification VARCHAR(100),
    category VARCHAR(50),
    p_10 FLOAT,
    p_12 FLOAT,
    course VARCHAR(100),
    ug_cgpa FLOAT,
    pg_cgpa FLOAT
);

-- -----------------------------------------------------
-- Table: Candidate_Demographics (New table to isolate derived field/dependency)
-- -----------------------------------------------------
CREATE TABLE Candidate_Demographics (
    candidate_id INT PRIMARY KEY,
    dob DATE NOT NULL,
    age INT, -- Retained column
    FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id) ON DELETE CASCADE
);