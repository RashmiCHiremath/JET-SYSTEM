#!/usr/bin/env pwsh

# Test Phase 2 APIs
$BASE_URL = "http://localhost:8080/api"

# Login to get token
Write-Host "=== 1. LOGIN ===" -ForegroundColor Cyan
$loginBody = @{username="admin"; password="admin123"} | ConvertTo-Json
Write-Host "Request: POST /api/auth/login"
Write-Host "Body: $loginBody"

try {
    $loginResponse = Invoke-WebRequest -Uri "$BASE_URL/auth/login" -Method POST -ContentType "application/json" -Body $loginBody -ErrorAction Stop
    $token = ($loginResponse.Content | ConvertFrom-Json).token
    Write-Host "✓ Login successful! Token: $($token.Substring(0, 20))..." -ForegroundColor Green
} catch {
    Write-Host "✗ Login failed: $_" -ForegroundColor Red
    exit 1
}

# Headers with token
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

# Test 1: Get Mock Tests
Write-Host "`n=== 2. GET MOCK TESTS ===" -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "$BASE_URL/mock-tests" -Method GET -Headers $headers -ErrorAction Stop
    $mockTests = $response.Content | ConvertFrom-Json
    Write-Host "✓ Mock Tests retrieved: $($mockTests.Count) tests" -ForegroundColor Green
    if ($mockTests.Count -gt 0) { Write-Host "Sample: $($mockTests[0] | ConvertTo-Json -Depth 1)" }
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}

# Test 2: Get Attendance
Write-Host "`n=== 3. GET ATTENDANCE ===" -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "$BASE_URL/attendance" -Method GET -Headers $headers -ErrorAction Stop
    $attendance = $response.Content | ConvertFrom-Json
    Write-Host "✓ Attendance retrieved: $($attendance.Count) records" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}

# Test 3: Get Exams
Write-Host "`n=== 4. GET EXAMS ===" -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "$BASE_URL/exams" -Method GET -Headers $headers -ErrorAction Stop
    $exams = $response.Content | ConvertFrom-Json
    Write-Host "✓ Exams retrieved: $($exams.Count) exams" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}

# Test 4: Get Results
Write-Host "`n=== 5. GET RESULTS ===" -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "$BASE_URL/results" -Method GET -Headers $headers -ErrorAction Stop
    $results = $response.Content | ConvertFrom-Json
    Write-Host "✓ Results retrieved: $($results.Count) results" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}

# Test 5: Get Certificates
Write-Host "`n=== 6. GET CERTIFICATES ===" -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "$BASE_URL/certificates" -Method GET -Headers $headers -ErrorAction Stop
    $certs = $response.Content | ConvertFrom-Json
    Write-Host "✓ Certificates retrieved: $($certs.Count) certificates" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}

# Test 6: Get Questions
Write-Host "`n=== 7. GET QUESTIONS ===" -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "$BASE_URL/questions" -Method GET -Headers $headers -ErrorAction Stop
    $questions = $response.Content | ConvertFrom-Json
    Write-Host "✓ Questions retrieved: $($questions.Count) questions" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}

# Test 7: Get Answers
Write-Host "`n=== 8. GET ANSWERS ===" -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "$BASE_URL/answers" -Method GET -Headers $headers -ErrorAction Stop
    $answers = $response.Content | ConvertFrom-Json
    Write-Host "✓ Answers retrieved: $($answers.Count) answers" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed: $_" -ForegroundColor Red
}

Write-Host "`n=== PHASE 2 API TEST COMPLETE ===" -ForegroundColor Green
