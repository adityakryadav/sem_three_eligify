-- ELIGIFY Mock Data Insertion (Updated with 20 Exams and Normalized Subjects)
SET SQL_SAFE_UPDATES = 0;
USE eligify_db;

-- Clear existing data before inserting new, expanded set
DELETE FROM Documents;
DELETE FROM Reservation;
DELETE FROM Eligibility;
DELETE FROM ExamSubject; -- UPDATED: Using normalized table
DELETE FROM Exam;

-- -----------------------------------------------------
-- Insert into Exam Table (20 Exams Total)
-- -----------------------------------------------------
INSERT INTO Exam (exam_id, exam_name, max_attempts, conducting_body, exam_level, exam_mode, website, exam_month, exam_type, fee_gen_ews, total_duration_mins) VALUES
(101, 'JEE Main', 3, 'NTA', 'National', 'Online', 'jeemain.nta.nic.in', 1, 'Engineering', 1000, 180),
(102, 'NEET UG', 2, 'NTA', 'National', 'Offline', 'neet.nta.nic.in', 5, 'Medical', 1500, 200),
(103, 'UPSC CSE', 6, 'UPSC', 'National', 'Offline', 'upsc.gov.in', 6, 'Civil Services', 100, 180),
(104, 'GATE (Engineering PG)', 99, 'IITs/IISc', 'National', 'Online', 'gate.iitk.ac.in', 2, 'Engineering', 1800, 180),
(105, 'CLAT (Law Entrance)', 99, 'Consortium of NLUs', 'National', 'Offline', 'consortiumofnlus.ac.in', 12, 'Law', 4000, 120),
-- New Exams
(106, 'BITSAT (Engineering)', 4, 'BITS Pilani', 'National', 'Online', 'bitsadmission.com', 4, 'Engineering', 3400, 180),
(107, 'UGEE (IIIT Hyderabad)', 2, 'IIIT Hyderabad', 'National', 'Online', 'iiit.ac.in/admissions/ug', 6, 'Engineering/Science', 2500, 180),
(108, 'MHT CET (Engineering/Pharmacy)', 2, 'CET Cell Maharashtra', 'State', 'Online', 'mahacet.org', 5, 'Engineering', 800, 180),
(109, 'CUET-UG (Common Univ. Entrance)', 99, 'NTA', 'National', 'Online', 'nta.ac.in/cuet', 5, 'Various UG', 750, 180),
(110, 'NDA (National Defence Academy)', 6, 'UPSC', 'National', 'Offline', 'upsc.gov.in/nda', 4, 'Defence', 100, 300),
(111, 'IAT (IISER Aptitude Test)', 2, 'IISERs', 'National', 'Online', 'iiseradmission.in', 6, 'Science', 2000, 180),
(112, 'ISI Entrance (Maths/Stats)', 99, 'Indian Statistical Institute', 'National', 'Offline', 'isical.ac.in', 5, 'Maths/Stats', 1500, 120),
(113, 'UCEED (Design Entrance)', 2, 'IIT Bombay', 'National', 'Online/Offline', 'uceed.iitb.ac.in', 1, 'Design', 3500, 180),
(114, 'AFCAT (Air Force Common Aptitude)', 99, 'IAF', 'National', 'Online', 'afcat.cdac.in', 2, 'Defence', 250, 120),
(115, 'CDS (Combined Defence Services)', 99, 'UPSC', 'National', 'Offline', 'upsc.gov.in/cds', 4, 'Defence', 200, 360),
(116, 'NEET-PG (Medical PG)', 99, 'NBE', 'National', 'Online', 'nbe.edu.in', 3, 'Medical PG', 5000, 210),
(117, 'CUET-PG (Common Univ. Entrance PG)', 99, 'NTA', 'National', 'Online', 'nta.ac.in/cuetpg', 6, 'Various PG', 800, 105),
(118, 'SSC-CGL (Govt. Job)', 99, 'SSC', 'National', 'Online', 'ssc.nic.in', 4, 'Government', 100, 120),
(119, 'VITEEE (Engineering)', 99, 'VIT', 'University', 'Online', 'viteee.vit.ac.in', 4, 'Engineering', 1350, 150),
(120, 'SRMJEE (Engineering)', 99, 'SRM Institute', 'University', 'Online', 'srmist.edu.in', 4, 'Engineering', 1200, 150);


-- -----------------------------------------------------
-- Insert into ExamSubject Table (Normalized)
-- -----------------------------------------------------
INSERT INTO ExamSubject (exam_id, subject_name) VALUES
(101, 'Physics'),
(101, 'Chemistry'),
(101, 'Mathematics'),
(102, 'Physics'),
(102, 'Chemistry'),
(102, 'Botany'),
(102, 'Zoology'),
(103, 'General Studies I'),
(103, 'General Studies II (CSAT)'),
(104, 'General Aptitude'),
(104, 'Engineering Mathematics'),
(104, 'Core Engineering Branch Subject'),
(105, 'English Language'),
(105, 'Current Affairs'),
(105, 'Legal Reasoning'),
(105, 'Logical Reasoning'),
(106, 'PCM/PCB'),
(106, 'English Proficiency'),
(106, 'Logical Reasoning'),
(107, 'Subject Proficiency Test'),
(107, 'Research Aptitude Test'),
(108, 'Physics'),
(108, 'Chemistry'),
(108, 'Mathematics/Biology'),
(109, 'Language'),
(109, 'Domain Subjects'),
(109, 'General Test'),
(110, 'Mathematics'),
(110, 'General Ability Test (GAT)'),
(111, 'Physics'),
(111, 'Chemistry'),
(111, 'Biology'),
(111, 'Mathematics'),
(112, 'Mathematics'),
(112, 'Statistics'),
(112, 'English'),
(113, 'Aptitude'),
(113, 'Observation'),
(113, 'Design Sketching'),
(114, 'General Awareness'),
(114, 'Verbal Ability'),
(114, 'Numerical Ability'),
(114, 'Reasoning'),
(115, 'English'),
(115, 'General Knowledge'),
(115, 'Elementary Mathematics'),
(116, 'Medical Sciences'),
(117, 'General Section'),
(117, 'Domain Specific Knowledge'),
(118, 'Quantitative Aptitude'),
(118, 'General Intelligence'),
(118, 'English Comprehension'),
(118, 'General Awareness'),
(119, 'PCM/PCB'),
(119, 'English'),
(119, 'Aptitude'),
(120, 'Physics'),
(120, 'Chemistry'),
(120, 'Mathematics/Biology');


-- -----------------------------------------------------
-- Insert into Eligibility Table (Mandatory academic checks)
-- -----------------------------------------------------
INSERT INTO Eligibility (exam_id, min_age, max_age, min_10_percent, min_12_percent, min_ug_cgpa) VALUES
(101, 17, 25, 60, 75, 0.0), 
(102, 17, 99, 50, 60, 0.0), 
(103, 21, 32, 50, 50, 6.0),
(104, 20, 99, 50, 50, 6.5), 
(105, 17, 99, 50, 45, 0.0),
-- New Eligibility Criteria
(106, 17, 99, 60, 75, 0.0), -- BITSAT: 75% aggregate in 12th
(107, 17, 99, 60, 60, 0.0), -- UGEE: 60% in 12th
(108, 17, 99, 50, 45, 0.0), -- MHT CET: 45% in 12th (General)
(109, 17, 99, 50, 50, 0.0), -- CUET-UG: 50% average passing score
(110, 16, 19, 50, 60, 0.0), -- NDA: Strict age limit, 60% in 12th PCM for Navy/Air Force
(111, 17, 99, 60, 60, 0.0), -- IAT: 60% in 12th
(112, 17, 99, 70, 75, 0.0), -- ISI: High 12th percentage requirement
(113, 17, 99, 50, 50, 0.0), -- UCEED: 50% in 12th
(114, 20, 24, 50, 50, 6.0), -- AFCAT: 60% in graduation (6.0 CGPA)
(115, 19, 24, 50, 50, 6.0), -- CDS: 60% in graduation (6.0 CGPA)
(116, 22, 99, 50, 50, 7.0), -- NEET-PG: MBBS degree (7.0 CGPA assumption)
(117, 20, 99, 50, 50, 5.5), -- CUET-PG: 5.5 CGPA in UG
(118, 18, 32, 50, 50, 5.0), -- SSC-CGL: Graduation required (5.0 CGPA assumption)
(119, 17, 99, 60, 60, 0.0), -- VITEEE: 60% in 12th
(120, 17, 99, 50, 50, 0.0); -- SRMJEE: 50% in 12th


-- -----------------------------------------------------
-- Insert into Reservation Table
-- -----------------------------------------------------
INSERT INTO Reservation (exam_id, ews_percent, obc_ncl_percent, sc_percent, st_percent) VALUES
(101, 10, 27, 15, 7),
(102, 10, 27, 15, 7),
(103, 10, 27, 15, 7),
(104, 10, 27, 15, 7),
(105, 10, 27, 15, 7),
(106, 10, 27, 15, 7),
(107, 10, 27, 15, 7),
(108, 10, 27, 15, 7),
(109, 10, 27, 15, 7),
(110, 10, 27, 15, 7),
(111, 10, 27, 15, 7),
(112, 10, 27, 15, 7),
(113, 10, 27, 15, 7),
(114, 10, 27, 15, 7),
(115, 10, 27, 15, 7),
(116, 10, 27, 15, 7),
(117, 10, 27, 15, 7),
(118, 10, 27, 15, 7),
(119, 10, 27, 15, 7),
(120, 10, 27, 15, 7);

-- -----------------------------------------------------
-- Insert into Documents Table
-- -----------------------------------------------------
INSERT INTO Documents (exam_id, caste_certificate, domicile, birth_certificate, photo, signature, aadhar, ug_degree, pg_degree) VALUES
(101, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE),
(102, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE),
(103, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE),
(104, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE),
(105, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE),
(106, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE), -- BITSAT
(107, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, FALSE), -- UGEE
(108, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE), -- MHT CET
(109, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE), -- CUET-UG
(110, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE), -- NDA
(111, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE), -- IAT
(112, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, FALSE), -- ISI
(113, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE), -- UCEED
(114, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE), -- AFCAT
(115, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE), -- CDS
(116, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE), -- NEET-PG
(117, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE), -- CUET-PG
(118, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE), -- SSC-CGL
(119, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE), -- VITEEE
(120, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE); -- SRMJEE