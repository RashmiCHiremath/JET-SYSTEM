USE jet_db;

CREATE TABLE IF NOT EXISTS fees (
    fee_id BIGINT NOT NULL AUTO_INCREMENT,
    student_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    fee_amount DECIMAL(10,2) NOT NULL,
    due_date DATE NULL,
    fee_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    PRIMARY KEY (fee_id),
    CONSTRAINT fk_fees_student FOREIGN KEY (student_id) REFERENCES students (student_id),
    CONSTRAINT fk_fees_course FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

CREATE TABLE IF NOT EXISTS payments (
    payment_id BIGINT NOT NULL AUTO_INCREMENT,
    fee_id BIGINT NOT NULL,
    payment_date DATE NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    transaction_reference VARCHAR(100) NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'SUCCESS',
    PRIMARY KEY (payment_id),
    CONSTRAINT fk_payments_fee FOREIGN KEY (fee_id) REFERENCES fees (fee_id)
);