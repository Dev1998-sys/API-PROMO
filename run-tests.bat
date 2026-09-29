@echo off
REM Test Execution Script for API Automation
REM This script runs the TestNG tests and generates Allure report

echo ========================================
echo   API Automation Test Execution
echo ========================================
echo.

cd /d "D:\work branch\api-automation"

REM Set classpath with all required JARs
set CLASSPATH=.;target\classes;target\test-classes

REM Add Maven repository JARs to classpath
for /r "%USERPROFILE%\.m2\repository" %%F in (*.jar) do (
    set CLASSPATH=!CLASSPATH!;%%F
)

echo Running TestNG Tests...
echo.

REM Run TestNG with testng.xml
java -cp %CLASSPATH% org.testng.TestNG testng.xml

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Tests completed successfully!
    echo.
    echo Generating Allure Report...
    REM Generate Allure report
    java -cp %CLASSPATH% org.testng.TestNG testng.xml -Dorg.testng.reporter.CustomReporterClass=io.qameta.allure.listener.AllureTestLifecycle
) else (
    echo.
    echo Tests failed with error code %ERRORLEVEL%
)

pause
