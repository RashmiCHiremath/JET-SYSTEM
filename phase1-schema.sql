CREATE DATABASE IF NOT EXISTS jet_db;
USE jet_db;

CREATE TABLE IF NOT EXISTS roles (
    role_id BIGINT NOT NULL AUTO_INCREMENT,
    role_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (role_id),
    UNIQUE KEY uk_roles_role_name (role_name)
);

CREATE TABLE IF NOT EXISTS colleges (
    college_id BIGINT NOT NULL AUTO_INCREMENT,
    college_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (college_id)
);

CREATE TABLE IF NOT EXISTS courses (
    course_id BIGINT NOT NULL AUTO_INCREMENT,
    course_name VARCHAR(255) NOT NULL,
    fee DOUBLE NOT NULL,
    PRIMARY KEY (course_id)
);

CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT NOT NULL AUTO_INCREMENT,
    role_id BIGINT NOT NULL,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    mobile VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    PRIMARY KEY (user_id),
    UNIQUE KEY uk_users_username (username),
    UNIQUE KEY uk_users_email (email),
    CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles (role_id)
);

CREATE TABLE IF NOT EXISTS trainers (
    trainer_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NULL,
    PRIMARY KEY (trainer_id),
    UNIQUE KEY uk_trainers_user_id (user_id),
    CONSTRAINT fk_trainers_user FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE IF NOT EXISTS batches (
    batch_id BIGINT NOT NULL AUTO_INCREMENT,
    course_id BIGINT NULL,
    trainer_id BIGINT NULL,
    PRIMARY KEY (batch_id),
    CONSTRAINT fk_batches_course FOREIGN KEY (course_id) REFERENCES courses (course_id),
    CONSTRAINT fk_batches_trainer FOREIGN KEY (trainer_id) REFERENCES trainers (trainer_id)
);

CREATE TABLE IF NOT EXISTS students (
    student_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NULL,
    college_id BIGINT NULL,
    course_id BIGINT NULL,
    PRIMARY KEY (student_id),
    UNIQUE KEY uk_students_user_id (user_id),
    CONSTRAINT fk_students_user FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT fk_students_college FOREIGN KEY (college_id) REFERENCES colleges (college_id),
    CONSTRAINT fk_students_course FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

CREATE TABLE IF NOT EXISTS batch_students (
    student_id BIGINT NOT NULL,
    batch_id BIGINT NOT NULL,
    PRIMARY KEY (student_id, batch_id),
    CONSTRAINT fk_batch_students_student FOREIGN KEY (student_id) REFERENCES students (student_id),
    CONSTRAINT fk_batch_students_batch FOREIGN KEY (batch_id) REFERENCES batches (batch_id)
);