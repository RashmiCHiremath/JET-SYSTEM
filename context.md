# JET Project Prompt Pack

Use this file as a reusable prompt library for other AI tools. Keep each prompt focused on one outcome, one code area, and one validation step.

## Project Summary

JET is a Job Exam Training platform built with React, Spring Boot, Spring Security, JWT, JPA, and MySQL.

## Current Project State

- Phase 1 backend, database, and frontend connection are in place and stable.
- Phase 2 training features are implemented and verified across backend API and frontend build checks.
- The live MySQL database `jet_db` contains the core schema for users, roles, colleges, courses, batches, students, trainers, and batch-to-student mappings.
- The core JET domain modules for College, Course, Batch, Student, Trainer, and BatchStudent are implemented in the backend and aligned with the existing entity/controller/service/repository patterns.
- The backend compiles successfully with Maven (`mvn clean compile -DskipTests` -> BUILD SUCCESS).
- The frontend builds successfully with Vite (`npm run build` -> build completed successfully).
- The backend is configured to run on port 8080 and remains compatible with the project requirement to keep that port fixed.
- Admin CRUD pages for colleges, courses, batches, students, and trainers are present in the frontend and aligned with the live backend endpoints.

## Copy/Paste Prompts

### 1. General Code Task Prompt

Work on the JET project in the current workspace.

Requirements:

- Start from the most concrete file, failing behavior, or feature gap.
- Keep the change minimal and aligned with the current code style.
- Prefer the owning abstraction over broad search.
- Validate the result with compile, build, or a targeted check.

### 2. Backend Feature Prompt

Add or update a Spring Boot backend feature in JET.

Requirements:

- Use the existing package structure under `Backend/src/main/java/com/jet/backend`.
- Keep changes consistent with the current controller, service, repository, and entity patterns.
- Use JPA entities and Spring Data repositories where appropriate.
- Preserve authentication and security behavior unless the task explicitly changes it.
- Validate with `mvn compile` or a targeted backend check.

### 3. Frontend Feature Prompt

Add or update a React frontend feature in JET.

Requirements:

- Use the existing React + Vite structure in `Frontend/src`.
- Keep the UI consistent with the current design language unless the task asks for a redesign.
- Connect the UI to backend APIs through the shared API client.
- Handle loading, error, and empty states when data comes from the backend.
- Validate with a frontend build.

### 4. Database Prompt

Update the JET MySQL schema.

Requirements:

- Use `jet_db` as the database name.
- Keep the schema aligned with the current backend entities.
- Include only the requested phase tables.
- Make foreign keys, join tables, and uniqueness rules match the current data model.
- Validate the SQL against the live MySQL database or Workbench connection.

### 5. MySQL Workbench Prompt

Help me make the JET tables visible in MySQL Workbench.

Requirements:

- Confirm that the SQL script was executed on the same MySQL server Workbench is connected to.
- Confirm that the correct schema is selected, usually `jet_db`.
- Suggest refresh steps if the tables do not appear immediately.
- Prefer direct MySQL checks over assumptions.

### 6. Authentication Prompt

Work on JET login, registration, or JWT authentication.

Requirements:

- Preserve the current Spring Security setup unless the task explicitly changes it.
- Keep token generation, request filtering, and protected routes aligned.
- Ensure the frontend stores and sends the backend token correctly when needed.
- Validate both login success and a protected endpoint request.

### 7. Debugging Prompt

Find and fix the backend or frontend issue in the JET project.

Requirements:

- Start from the smallest nearby code path that controls the behavior.
- Form one falsifiable local hypothesis before editing.
- Make the smallest safe edit that tests the hypothesis.
- Validate the same slice immediately after the edit.

### 8. Phase 1 Prompt

Continue Phase 1 of the JET project.

Requirements:

- Focus on roles, users, students, colleges, trainers, courses, batches, and batch_students.
- Keep authentication and CRUD endpoints consistent with the current Phase 1 structure.
- Keep the schema and backend entities aligned.
- Validate changes with compile, build, or direct database verification.

### 9. Phase 2 Prompt

Continue Phase 2 of the JET project.

Requirements:

- Focus on attendance, mock tests, questions, answers, exams, results, and certificates.
- Keep database tables and backend entities aligned with the project plan.
- Add APIs and UI slices only when the schema and relationships are ready.
- Validate the schema in MySQL and the backend compile after changes.

### 10. Phase 3 Prompt

Continue Phase 3 of the JET project.

Requirements:

- Focus on companies, jobs, and placements.
- Keep the work consistent with the existing JET backend and frontend structure.
- Use the same incremental approach as earlier phases.
- Validate each new feature slice before expanding scope.

### 11. Phase 4 Prompt

Continue Phase 4 of the JET project.

Requirements:

- Focus on fees and payments.
- Keep payment logic isolated from earlier phase work.
- Preserve the existing schema and security patterns.
- Validate the database and backend behavior after changes.

### 12. Refactor Prompt

Refactor the JET code without changing behavior.

Requirements:

- Keep the public API and data model stable unless the task explicitly changes them.
- Prefer small, mechanical improvements over large rewrites.
- Do not touch unrelated code.
- Validate that the build still passes after the refactor.

### 13. Code Review Prompt

Review the JET code for bugs, risks, regressions, and missing tests.

Requirements:

- Prioritize findings by severity.
- Reference exact files and lines when possible.
- Focus on behavior, security, data integrity, and validation gaps.
- Avoid broad summaries until after the issues are listed.

### 14. Validation Prompt

Verify the latest JET change.

Requirements:

- Use the narrowest useful validation step.
- Prefer compile, build, or a direct database check over a broad manual review.
- Re-run the same validation if the first pass fails and the failure is local.
- Do not expand scope until the touched slice is validated.

### 15. Status Update Prompt

Update and document the current project status in context.md.

Requirements:

- Review the current state of all phases (Phase 1, Phase 2, Phase 3, Phase 4).
- Check backend compilation status, frontend build status, and database schema alignment.
- Document any completed features, in-progress work, or blockers.
- Update the "Current Project State" section with the latest findings.
- Include build status, test results, and any known issues.
- Validate that all status entries are accurate before finalizing.

### 16. Progress Tracking Prompt

Track and report on JET project completion status.

Requirements:

- List all completed phases and features with verification evidence.
- Identify any in-progress work and expected completion dates.
- Document known issues, blockers, or technical debt.
- Provide a high-level completion percentage for each phase.
- Include a summary of the next planned work items.
- Keep this information current as work progresses.

### 17. Project Health Check Prompt

Perform a comprehensive health check of the JET project.

Requirements:

- Verify backend compiles successfully with no errors or warnings.
- Verify frontend builds without critical issues.
- Verify database schema exists and is aligned with backend entities.
- Check that all authentication flows work end-to-end.
- Document any configuration issues or missing dependencies.
- Provide a summary of system readiness for the next phase.

## Useful File Paths

- Backend application config: `Backend/src/main/resources/application.properties`
- Phase 1 schema: `Database/phase1-schema.sql`
- Phase 2 schema: `Database/phase2-schema.sql`
- Database notes: `Database/README.md`
- Backend entry point: `Backend/src/main/java/com/jet/backend/JetBackendApplication.java`
- Frontend API client: `Frontend/src/services/api.js`
- Frontend router: `Frontend/src/routes/AppRouter.jsx`

## Current Technical Notes

- The backend compiles successfully in this workspace.
- The frontend build also completes successfully in this workspace.
- The backend is configured for JWT-based authentication and CORS for the Vite frontend origin.
- The live MySQL database is `jet_db`.
- Phase 1 tables already exist in the live database.
- Phase 2 training tables have been created and are operational in the live database.
- Core modules now include College, Course, Batch, Student, Trainer, and BatchStudent association handling.
- The default admin seed user is `admin` with password `admin123`.
- The project requirement to keep the backend on port 8080 is maintained.

## Reusable Prompt Pattern

When asking another AI tool for help, use this structure:

1. State the exact outcome you want.
2. Name the file, folder, or phase.
3. Mention the current behavior or error.
4. Ask for the smallest safe change first.
5. Ask for validation after the change.

Example:

"Update the JET Spring Boot backend to add the next Phase 2 entity and repository. Keep the change minimal, align it with the current package structure, and validate it with a backend compile."
