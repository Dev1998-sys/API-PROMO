#!/usr/bin/env pwsh

# API Automation Test Execution Script
# This script compiles, runs tests, and generates Allure report

Write-Host "========================================" -ForegroundColor Green
Write-Host "   API Automation Test Execution" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

$projectPath = "D:\work branch\api-automation"
$m2Repo = "$env:USERPROFILE\.m2\repository"
$targetDir = "$projectPath\target"
$allureResultsDir = "$targetDir\allure-results"
$allureReportDir = "$targetDir\allure-report"

# Change to project directory
Set-Location $projectPath

Write-Host "Step 1: Compiling project..." -ForegroundColor Cyan

# Build classpath with all dependencies
$classpath = "$projectPath\src\test\java;$projectPath\target\test-classes;$projectPath\target\classes"

# Add all JARs from Maven repository to classpath
$jars = Get-ChildItem -Path $m2Repo -Filter "*.jar" -Recurse
foreach ($jar in $jars) {
    $classpath += ";$($jar.FullName)"
}

Write-Host "Classpath prepared with $(($jars).Count) dependencies" -ForegroundColor Yellow
Write-Host ""

Write-Host "Step 2: Running TestNG Tests..." -ForegroundColor Cyan
Write-Host "Test Configuration: testng.xml" -ForegroundColor Yellow

# Create allure-results directory if it doesn't exist
if (-not (Test-Path $allureResultsDir)) {
    New-Item -ItemType Directory -Path $allureResultsDir -Force | Out-Null
    Write-Host "Created directory: $allureResultsDir" -ForegroundColor Yellow
}

# Run TestNG with test configuration
try {
    $output = & java -cp $classpath org.testng.TestNG testng.xml 2>&1
    Write-Host $output
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✓ Tests completed successfully!" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "⚠ Tests completed with status code: $LASTEXITCODE" -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error running tests: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Step 3: Test Results Location" -ForegroundColor Cyan
Write-Host "Test Results: $allureResultsDir" -ForegroundColor Yellow

# Check if test results exist
if (Test-Path "$projectPath\test-output") {
    Write-Host "TestNG Report: $projectPath\test-output" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "   Test Execution Complete" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Test Results are available in:" -ForegroundColor Cyan
Write-Host "  1. TestNG Report: $projectPath\test-output\index.html" -ForegroundColor Yellow
Write-Host "  2. Allure Results: $allureResultsDir" -ForegroundColor Yellow
Write-Host ""
Write-Host "To view TestNG Report, open: $projectPath\test-output\index.html" -ForegroundColor Green
