USE jet_db;

CREATE TABLE IF NOT EXISTS companies (
    company_id BIGINT NOT NULL AUTO_INCREMENT,
    company_name VARCHAR(255) NOT NULL,
    website VARCHAR(255) NULL,
    location VARCHAR(255) NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    PRIMARY KEY (company_id),
    UNIQUE KEY uk_companies_company_name (company_name)
);

CREATE TABLE IF NOT EXISTS jobs (
    job_id BIGINT NOT NULL AUTO_INCREMENT,
    company_id BIGINT NOT NULL,
    job_title VARCHAR(255) NOT NULL,
    job_description VARCHAR(1000) NULL,
    location VARCHAR(255) NULL,
    package_offered VARCHAR(100) NULL,
    last_date DATE NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    PRIMARY KEY (job_id),
    CONSTRAINT fk_jobs_company FOREIGN KEY (company_id) REFERENCES companies (company_id)
);

CREATE TABLE IF NOT EXISTS placements (
    placement_id BIGINT NOT NULL AUTO_INCREMENT,
    job_id BIGINT NOT NULL,
    student_id BIGINT NOT NULL,
    applied_date DATE NOT NULL,
    placement_status VARCHAR(20) NOT NULL DEFAULT 'APPLIED',
    PRIMARY KEY (placement_id),
    UNIQUE KEY uk_placements_job_student (job_id, student_id),
    CONSTRAINT fk_placements_job FOREIGN KEY (job_id) REFERENCES jobs (job_id),
    CONSTRAINT fk_placements_student FOREIGN KEY (student_id) REFERENCES students (student_id)
);