# JET (Job Exam Training) - Project Setup & Development Guide

## 1. Project Overview

JET (Job Exam Training) is a web-based training management system for students, trainers, colleges, administrators, and placement activities.

### Technology Stack

- Frontend: React 19 + Vite + Material UI
- Backend: Java 21 + Spring Boot 3.5.x
- Database: MySQL 8
- API: REST APIs
- Authentication: Spring Security + JWT
- API documentation: Swagger/OpenAPI
- API testing: Postman
- Build tool: Maven

> Source: JET SRS v1.0

---

# 2. Development Strategy

Do NOT build all modules at once.

Build the project in phases:

## Phase 1 - Core System

Priority: HIGH

1. Project/environment setup
2. MySQL database
3. Spring Boot backend
4. Roles and users
5. JWT authentication
6. Students
7. Colleges
8. Trainers
9. Courses
10. Batches
11. Batch-student relationship
12. React frontend
13. Login page
14. Role-based dashboards
15. CRUD screens
16. Connect frontend with backend
17. Test APIs

## Phase 2 - Training

Priority: MEDIUM

1. Attendance
2. Mock Tests
3. Questions
4. Answers
5. Exams
6. Results
7. Certificates

## Phase 3 - Placements

Priority: MEDIUM

1. Companies
2. Jobs
3. Placements

## Phase 4 - Finance

Priority: LOW

1. Fees
2. Payments

## System Features

Add these across the project:

- Notifications
- Permissions
- Audit Logs
- Validation
- Error handling
- Reporting

The SRS identifies Authentication, Students, Colleges, Trainers, Courses and Batches as Phase 1; Attendance and Mock Tests as Phase 2; Placements as Phase 3; and Payments as Phase 4.

---

# 3. Prerequisites

Before starting, install:

- Java 21
- Maven
- Node.js
- npm
- MySQL 8
- VS Code
- Postman
- Git

## Verify installations

Open Command Prompt or VS Code terminal:

```cmd
java -version
mvn -version
node -v
npm -v
mysql --version
git --version
```

All required commands should work before continuing.

---

# 4. Create the Project Folder

Create:

```text
JET/
├── backend/
└── frontend/
```

Open the `JET` folder in VS Code.

Recommended final structure:

```text
JET/
├── backend/
├── frontend/
├── database/
├── docs/
└── PROJECT.md
```

---

# 5. Create the MySQL Database

Open MySQL Workbench or MySQL Command Prompt.

Run:

```sql
CREATE DATABASE jet_db;
```

Check:

```sql
SHOW DATABASES;
```

Select it:

```sql
USE jet_db;
```

Do not create every future table manually yet. We will build the Phase 1 schema first.

---

# 6. Phase 1 Database Design

The initial design contains these important tables:

```text
roles
users
students
colleges
trainers
courses
batches
batch_students
```

Relationships:

```text
roles 1:N users

users 1:1 students
users 1:1 trainers

colleges 1:N students

courses 1:N batches
trainers 1:N batches

students M:N batches
          |
     batch_students
```

The existing database design document defines these primary relationships.

---

# 7. Create Spring Boot Backend

Use Spring Initializr or create the project from VS Code/your preferred Spring Boot workflow.

Recommended settings:

```text
Project: Maven
Language: Java
Spring Boot: 3.5.x
Group: com.jet
Artifact: backend
Name: jet-backend
Package: com.jet.backend
Java: 21
```

Dependencies:

```text
Spring Web
Spring Data JPA
MySQL Driver
Spring Security
Validation
Lombok
```

Add JWT and Swagger/OpenAPI after the basic backend starts successfully.

---

# 8. Backend Folder Structure

Create:

```text
backend/
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── jet/
        │           └── backend/
        │               ├── config/
        │               ├── controller/
        │               ├── dto/
        │               ├── entity/
        │               ├── exception/
        │               ├── repository/
        │               ├── security/
        │               ├── service/
        │               └── JetBackendApplication.java
        │
        └── resources/
            └── application.properties
```

Keep the layers separate:

```text
Controller
    ↓
Service
    ↓
Repository
    ↓
Entity
    ↓
MySQL
```

---

# 9. Configure MySQL

Open:

```text
backend/src/main/resources/application.properties
```

Add:

```properties
spring.application.name=jet-backend

spring.datasource.url=jdbc:mysql://localhost:3306/jet_db
spring.datasource.username=root
spring.datasource.password=YOUR_MYSQL_PASSWORD

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

server.port=8080
```

Replace:

```text
YOUR_MYSQL_PASSWORD
```

with your MySQL password.

Do not commit real passwords to Git.

---

# 10. Start the Backend

From the `backend` folder:

```cmd
mvn spring-boot:run
```

Expected result:

```text
Started JetBackendApplication
```

Test:

```text
http://localhost:8080
```

At this point an empty response or default error page is acceptable. The important thing is that Spring Boot starts without errors.

---

# 11. Create the Role Entity

Create:

```text
entity/Role.java
```

The role table should contain:

```text
role_id
role_name
```

Primary key:

```text
role_id
```

Create:

```text
RoleRepository
```

under:

```text
repository/
```

---

# 12. Create the User Entity

Create:

```text
entity/User.java
```

Fields based on the database design:

```text
user_id
role_id
username
password
email
mobile
status
```

Important:

- Store passwords securely.
- Do not store plain-text passwords.
- Role should be related to the Role entity.

Create:

```text
UserRepository
UserService
UserController
```

---

# 13. Seed Initial Roles

Create initial roles:

```text
SUPER_ADMIN
ADMIN
STUDENT
TRAINER
COLLEGE_COORDINATOR
PLACEMENT_OFFICER
HR
```

These correspond to the stakeholders/roles identified in the SRS.

For development, insert them through a controlled initialization mechanism or SQL script.

Example SQL:

```sql
INSERT INTO roles (role_name) VALUES
('SUPER_ADMIN'),
('ADMIN'),
('STUDENT'),
('TRAINER'),
('COLLEGE_COORDINATOR'),
('PLACEMENT_OFFICER'),
('HR');
```

---

# 14. Implement JWT Authentication

Authentication flow:

```text
User
  ↓
Login
  ↓
POST /api/auth/login
  ↓
Check username/password
  ↓
Spring Security
  ↓
Generate JWT
  ↓
Return JWT
```

Create:

```text
security/
├── JwtService.java
├── JwtAuthenticationFilter.java
├── CustomUserDetailsService.java
└── SecurityConfig.java
```

Create:

```text
controller/AuthController.java
service/AuthService.java
dto/LoginRequest.java
dto/LoginResponse.java
```

Initial endpoints:

```text
POST /api/auth/login
POST /api/auth/register
```

Do not move to frontend authentication until these endpoints work in Postman.

---

# 15. Test Login in Postman

Create:

```text
POST http://localhost:8080/api/auth/login
```

Example request:

```json
{
  "username": "admin",
  "password": "password"
}
```

Expected response:

```json
{
  "token": "JWT_TOKEN_HERE"
}
```

The exact response structure can be changed later, but login must successfully authenticate and return a JWT.

---

# 16. Create College Module

Entity:

```text
College
```

Fields from the design:

```text
college_id
college_name
```

Create:

```text
College.java
CollegeRepository.java
CollegeService.java
CollegeController.java
```

CRUD endpoints:

```text
GET    /api/colleges
GET    /api/colleges/{id}
POST   /api/colleges
PUT    /api/colleges/{id}
DELETE /api/colleges/{id}
```

Test all endpoints in Postman.

---

# 17. Create Course Module

Entity:

```text
Course
```

Fields:

```text
course_id
course_name
fee
```

CRUD:

```text
GET    /api/courses
GET    /api/courses/{id}
POST   /api/courses
PUT    /api/courses/{id}
DELETE /api/courses/{id}
```

Use a numeric monetary type for `fee` rather than a text field when implementing the final entity.

---

# 18. Create Trainer Module

Entity:

```text
Trainer
```

Fields from the database design:

```text
trainer_id
user_id
```

Relationship:

```text
User 1:1 Trainer
```

Create:

```text
Trainer.java
TrainerRepository.java
TrainerService.java
TrainerController.java
```

---

# 19. Create Batch Module

Entity:

```text
Batch
```

The database design defines:

```text
batch_id
course_id
trainer_id
```

Relationship:

```text
Course 1:N Batch
Trainer 1:N Batch
```

Create:

```text
Batch.java
BatchRepository.java
BatchService.java
BatchController.java
```

CRUD endpoints:

```text
GET    /api/batches
GET    /api/batches/{id}
POST   /api/batches
PUT    /api/batches/{id}
DELETE /api/batches/{id}
```

---

# 20. Create Student Module

The database design defines:

```text
student_id
user_id
college_id
course_id
batch_id
```

Create:

```text
Student.java
StudentRepository.java
StudentService.java
StudentController.java
```

Student relationships:

```text
Student → User
Student → College
Student → Course
Student → Batch
```

Student CRUD:

```text
GET    /api/students
GET    /api/students/{id}
POST   /api/students
PUT    /api/students/{id}
DELETE /api/students/{id}
```

---

# 21. Create BatchStudent Module

Because students and batches have a many-to-many relationship, use:

```text
batch_students
```

Fields:

```text
batch_student_id
batch_id
student_id
```

Relationship:

```text
Student M:N Batch
```

Create:

```text
BatchStudent.java
BatchStudentRepository.java
BatchStudentService.java
BatchStudentController.java
```

---

# 22. Add Validation

Use Jakarta Validation.

Examples:

```text
username → required
email → valid email
password → required
college_name → required
course_name → required
```

Example annotations:

```java
@NotBlank
@Email
@Size
```

Return meaningful validation errors from the API.

---

# 23. Add Global Exception Handling

Create:

```text
exception/
├── GlobalExceptionHandler.java
├── ResourceNotFoundException.java
└── ErrorResponse.java
```

Handle:

```text
404 - Resource not found
400 - Validation error
401 - Unauthorized
403 - Forbidden
500 - Internal server error
```

---

# 24. Add Swagger/OpenAPI

Add Swagger/OpenAPI support to the backend.

The SRS specifies Swagger/OpenAPI for API documentation.

After configuration, verify the generated API documentation from the application.

Document:

```text
Authentication
Users
Students
Colleges
Trainers
Courses
Batches
```

---

# 25. Create React Frontend

From the JET root folder:

```cmd
npm create vite@latest frontend -- --template react
```

Move into frontend:

```cmd
cd frontend
```

Install:

```cmd
npm install
```

Install Material UI:

```cmd
npm install @mui/material @emotion/react @emotion/styled
```

Install routing:

```cmd
npm install react-router-dom
```

Start:

```cmd
npm run dev
```

---

# 26. Frontend Folder Structure

Use:

```text
frontend/
└── src/
    ├── components/
    ├── pages/
    │   ├── auth/
    │   ├── admin/
    │   ├── student/
    │   └── trainer/
    ├── layouts/
    ├── services/
    ├── context/
    ├── routes/
    ├── utils/
    ├── App.jsx
    └── main.jsx
```

---

# 27. First React Pages

Create:

```text
Login
AdminDashboard
StudentDashboard
TrainerDashboard
CollegeList
CourseList
BatchList
StudentList
TrainerList
```

Start with:

```text
Login
    ↓
Dashboard
```

Do not build every page before connecting the backend.

---

# 28. Connect React to Spring Boot

Create:

```text
src/services/api.js
```

Configure the frontend to call:

```text
http://localhost:8080/api
```

Recommended flow:

```text
React
  ↓
API service
  ↓
Spring Boot REST API
  ↓
Service
  ↓
Repository
  ↓
MySQL
```

---

# 29. Frontend Login Flow

```text
Login Page
    ↓
username + password
    ↓
POST /api/auth/login
    ↓
JWT
    ↓
Store token
    ↓
Redirect to dashboard
 
```

Use the JWT for protected API requests.

---

# 30. Role-Based Frontend Routing

After login:

```text
SUPER_ADMIN
    ↓
Admin Dashboard

ADMIN
    ↓
Admin Dashboard

TRAINER
    ↓
Trainer Dashboard

STUDENT
    ↓
Student Dashboard

COLLEGE_COORDINATOR
    ↓
College Dashboard

PLACEMENT_OFFICER
    ↓
Placement Dashboard

HR
    ↓
HR Dashboard
```

The backend must also enforce authorization. Do not rely only on hiding frontend buttons.

---

# 31. Phase 1 Dashboard

Admin dashboard can initially show:

```text
-----------------------------------------
| JET ADMIN DASHBOARD                   |
-----------------------------------------
| Students | Trainers | Colleges       |
|   120    |    15    |      8         |
-----------------------------------------
| Courses  | Batches | Active Users    |
|    10    |    20   |      145        |
-----------------------------------------
```

Initially, use real database counts rather than hardcoded values.

---

# 32. Phase 2 - Attendance

Database relationship:

```text
students 1:N attendance
batches   1:N attendance
```

Create fields required by the actual attendance use case, such as:

```text
attendance_id
student_id
batch_id
date
status
```

Possible status:

```text
PRESENT
ABSENT
```

Features:

```text
Trainer marks attendance
Student views attendance
Admin views attendance reports
```

---

# 33. Phase 2 - Mock Tests

Database flow:

```text
Course
  ↓
Mock Test

  ↓
Questions
  ↓
Answers
```

The database design defines:

```text
courses 1:N mock_tests
mock_tests 1:N questions
questions 1:N answers
```

fileciteturn0file1L122-L127

Build:

```text
MockTest
Question
Answer
```

Then create APIs and React pages.

---

# 34. Phase 2 - Exams and Results

Flow:

```text
Course
  ↓
Exam
  ↓
Student writes exam
  ↓
Result
```

Database relationship:

```text
courses 1:N exams
exams 1:N results
```

Students have results through the student foreign key.

---

# 35. Certificates

Database design:

```text
certificate_id
student_id
course_id
```

Create certificate functionality after course completion/result functionality works.

---

# 36. Phase 3 - Placements

Flow:

```text
Company
   ↓
Job
   ↓
Student
   ↓
Placement
```

Database relationships:

```text
companies 1:N jobs
jobs 1:N placements
students 1:N placements
```

fileciteturn0file1L133-L135

Build:

```text
Company
Job
Placement
```

Features:

```text
Add company
Add job
View jobs
Student applies
Track placement
Placement officer manages placements
```

---

# 37. Phase 4 - Fees and Payments

Flow:

```text
Student
   ↓
Fee
   ↓
Payment
```

Database relationship:

```text
students 1:N fees
fees 1:N payments
```

fileciteturn0file1L130-L132

Build:

```text
Fee
Payment
```

Payment gateway integration should be treated as a later enhancement because the SRS lists it in the future roadmap.

---

# 38. Notifications

The database design contains:

```text
notifications
    notification_id
    user_id
```

Relationship:

```text
User 1:N Notifications
```

Use notifications for:

```text
New batch
Exam announcement
Attendance notification
Placement update
Fee reminder
Certificate available
```

---

# 39. Permissions

The database design contains:

```text
permissions
    permission_id
    role_id
```

Use this to move from simple role checking toward permission-based authorization.

Example:

```text
STUDENT
  VIEW_COURSE
  VIEW_RESULT
  VIEW_ATTENDANCE

TRAINER
  VIEW_STUDENT
  MARK_ATTENDANCE
  CREATE_MOCK_TEST

ADMIN
  CREATE_USER
  UPDATE_USER
  DELETE_USER
  MANAGE_COURSE
```

---

# 40. Audit Logs

The database design contains:

```text
audit_logs
    audit_id
    user_id
```

Use audit logging for important operations:

```text
Login
Create user
Update user
Delete user
Create course
Update course
Delete course
Update result
Placement changes
Payment changes
```

The SRS requires an audit trail for critical operations.

---

# 41. Testing Strategy

Test each backend module in Postman before connecting it to React.

For each CRUD module test:

```text
CREATE
READ ALL
READ BY ID
UPDATE
DELETE
```

Also test:

```text
Invalid ID
Missing required field
Invalid email
Unauthorized request
Wrong role
Expired/invalid JWT
```

---

# 42. Example API Testing Order

Test in this order:

```text
1. Login
2. Roles
3. Users
4. Colleges
5. Courses
6. Trainers
7. Batches
8. Students
9. Batch Students
10. Attendance
11. Mock Tests
12. Questions
13. Answers
14. Exams
15. Results
16. Certificates
17. Companies
18. Jobs
19. Placements
20. Fees
21. Payments
22. Notifications
23. Permissions
24. Audit Logs
```

---

# 43. Git Setup

From the JET root:

```cmd
git init
```

Create `.gitignore`.

Do NOT commit:

```text
node_modules/
target/
.env
application-local.properties
*.log
```

Make the first commit after the basic project runs:

```cmd
git add .
git commit -m "Initial JET project setup"
```

---

# 44. Development Rules

Follow these rules throughout the project:

### Rule 1

Build one module at a time.

### Rule 2

Test backend API before building its frontend.

### Rule 3

Never store plain-text passwords.

### Rule 4

Never put database passwords directly into Git.

### Rule 5

Use DTOs for API requests/responses where appropriate.

### Rule 6

Validate incoming data.

### Rule 7

Use proper HTTP status codes.

### Rule 8

Do not put business logic inside controllers.

### Rule 9

Do not connect React directly to MySQL.

### Rule 10

Backend must enforce authorization even if the frontend hides UI elements.

---

# 45. Recommended Milestones

## Milestone 1

```text
[ ] Java installed
[ ] Maven installed
[ ] Node installed
[ ] MySQL installed
[ ] VS Code ready
[ ] Postman ready
```

## Milestone 2

```text
[ ] jet_db created
[ ] Spring Boot created
[ ] Backend starts
[ ] MySQL connected
```

## Milestone 3

```text
[ ] Role entity
[ ] User entity
[ ] JWT authentication
[ ] Login API
[ ] Postman login test
```

## Milestone 4

```text
[ ] College CRUD
[ ] Course CRUD
[ ] Trainer CRUD
[ ] Batch CRUD
[ ] Student CRUD
[ ] BatchStudent
```

## Milestone 5

```text
[ ] React/Vite created
[ ] Material UI configured
[ ] Login page
[ ] Dashboard
[ ] API integration
[ ] JWT handling
```

## Milestone 6

```text
[ ] Attendance
[ ] Mock Tests
[ ] Exams
[ ] Results
[ ] Certificates
```

## Milestone 7

```text
[ ] Companies
[ ] Jobs
[ ] Placements
```

## Milestone 8

```text
[ ] Fees
[ ] Payments
[ ] Notifications
[ ] Permissions
[ ] Audit Logs
```

---

# 46. Final Target Architecture

```text
                         JET
                          |
             ┌────────────┴────────────┐
             |                         |
         FRONTEND                   BACKEND
             |                         |
       React 19 + Vite          Spring Boot 3.5.x
       Material UI                     |
             |                 ┌───────┴────────┐
             |                 |                |
          REST API         Spring Security   Services
             |                 |                |
             |                JWT          Repositories
             |                 |                |
             └─────────────────┴────────────────┘
                              |
                           MySQL 8
                              |
        ┌─────────────────────┼──────────────────────┐
        |                     |                      |
     Training              Exams                Placements
        |                     |                      |
 Students                 Results                Companies
 Trainers                 Certificates            Jobs
 Courses                                          Placements
 Batches
 Attendance
 Mock Tests
```

---

# 47. Important Source Notes

This guide follows the supplied JET SRS and database design.

The SRS specifies the main technology stack, functional modules, security requirements, non-functional requirements, and phased priorities.

The database design specifies the core tables and their primary relationships, including users/students/trainers, courses/batches, student-batch mapping, exams/results, fees/payments, and placement relationships.

Where the supplied documents do not specify exact implementation details (for example, exact JWT library configuration, exact DTO structures, or every field needed for future modules), treat the instructions above as the development plan rather than as requirements already stated in the source documents.

---

# 48. START HERE

Do these commands first:

```cmd
java -version
mvn -version
node -v
npm -v
mysql --version
git --version
```

Then create:

```text
JET/


├── backend/
├── frontend/
├── database/
├── docs/
└── PROJECT.md
```

### Current goal

Do NOT start Phase 2.

Do NOT build all tables.

Do NOT build all React pages.

First complete:

```text
Environment
   ↓
MySQL
   ↓
Spring Boot
   ↓
Database connection
   ↓
Role
   ↓
User
   ↓
JWT Login
   ↓
College
   ↓
Course
   ↓
Trainer
   ↓
Batch
   ↓
Student
   ↓
React
```

After each milestone, run and test the application before continuing.
