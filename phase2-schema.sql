USE jet_db;

CREATE TABLE IF NOT EXISTS attendance (
    attendance_id BIGINT NOT NULL AUTO_INCREMENT,
    student_id BIGINT NOT NULL,
    batch_id BIGINT NOT NULL,
    attendance_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (attendance_id),
    UNIQUE KEY uk_attendance_student_batch_date (student_id, batch_id, attendance_date),
    CONSTRAINT fk_attendance_student FOREIGN KEY (student_id) REFERENCES students (student_id),
    CONSTRAINT fk_attendance_batch FOREIGN KEY (batch_id) REFERENCES batches (batch_id)
);

CREATE TABLE IF NOT EXISTS mock_tests (
    mock_test_id BIGINT NOT NULL AUTO_INCREMENT,
    course_id BIGINT NOT NULL,
    test_name VARCHAR(255) NOT NULL,
    description VARCHAR(500) NULL,
    duration_minutes INT NOT NULL,
    total_marks INT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (mock_test_id),
    CONSTRAINT fk_mock_tests_course FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

CREATE TABLE IF NOT EXISTS questions (
    question_id BIGINT NOT NULL AUTO_INCREMENT,
    mock_test_id BIGINT NOT NULL,
    question_text VARCHAR(1000) NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL,
    correct_option CHAR(1) NOT NULL,
    marks INT NOT NULL DEFAULT 1,
    PRIMARY KEY (question_id),
    CONSTRAINT fk_questions_mock_test FOREIGN KEY (mock_test_id) REFERENCES mock_tests (mock_test_id)
);

CREATE TABLE IF NOT EXISTS answers (
    answer_id BIGINT NOT NULL AUTO_INCREMENT,
    question_id BIGINT NOT NULL,
    student_id BIGINT NULL,
    selected_option CHAR(1) NOT NULL,
    answer_text VARCHAR(500) NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (answer_id),
    CONSTRAINT fk_answers_question FOREIGN KEY (question_id) REFERENCES questions (question_id),
    CONSTRAINT fk_answers_student FOREIGN KEY (student_id) REFERENCES students (student_id)
);

CREATE TABLE IF NOT EXISTS exams (
    exam_id BIGINT NOT NULL AUTO_INCREMENT,
    course_id BIGINT NOT NULL,
    exam_name VARCHAR(255) NOT NULL,
    exam_date DATE NOT NULL,
    duration_minutes INT NOT NULL,
    total_marks INT NOT NULL,
    PRIMARY KEY (exam_id),
    CONSTRAINT fk_exams_course FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

CREATE TABLE IF NOT EXISTS results (
    result_id BIGINT NOT NULL AUTO_INCREMENT,
    exam_id BIGINT NOT NULL,
    student_id BIGINT NOT NULL,
    marks_obtained INT NOT NULL,
    total_marks INT NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    result_status VARCHAR(20) NOT NULL,
    PRIMARY KEY (result_id),
    UNIQUE KEY uk_results_exam_student (exam_id, student_id),
    CONSTRAINT fk_results_exam FOREIGN KEY (exam_id) REFERENCES exams (exam_id),
    CONSTRAINT fk_results_student FOREIGN KEY (student_id) REFERENCES students (student_id)
);

CREATE TABLE IF NOT EXISTS certificates (
    certificate_id BIGINT NOT NULL AUTO_INCREMENT,
    student_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    certificate_number VARCHAR(100) NOT NULL,
    issued_date DATE NOT NULL,
    PRIMARY KEY (certificate_id),
    UNIQUE KEY uk_certificates_certificate_number (certificate_number),
    CONSTRAINT fk_certificates_student FOREIGN KEY (student_id) REFERENCES students (student_id),
    CONSTRAINT fk_certificates_course FOREIGN KEY (course_id) REFERENCES courses (course_id)
);