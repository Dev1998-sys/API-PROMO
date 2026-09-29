# API Automation Test Suite with Allure Reports

## Project Structure

```
api-automation/
├── src/
│   ├── main/java/
│   └── test/java/
│       ├── F5_APIs/
│       │   ├── FilterAPI.java
│       │   ├── F5Pull0API.java
│       │   ├── F5PrePull1API.java
│       │   ├── F5RunPullAPI.java
│       │   ├── F5CoreBundleAPI.java
│       │   ├── F5RunModulesAPI.java
│       │   ├── F5ProvenanceAPI.java
│       │   ├── F5ResolveLaddersAPI.java
│       │   ├── F5ResolveStoreAPI.java
│       │   ├── F5ResolveProductAPI.java
│       │   └── F5ResolveProductFilterLadderAPI.java
│       └── utilities/
│           ├── APIConstants.java
│           └── AllureTestListener.java
├── pom.xml
├── testng.xml
├── run-tests.ps1
└── VALIDATION_REPORT.txt
```

## Prerequisites

- Java 21+ installed
- Maven 3.6+ (optional, for direct Maven commands)
- Allure CommandLine Tool (optional, for viewing reports)

## How to Run Tests

### Option 1: Run Tests with PowerShell Script (Recommended)

```powershell
cd "D:\work branch\api-automation"
.\run-tests.ps1
```

### Option 2: Run Tests with Maven

```bash
cd "D:\work branch\api-automation"
mvn clean test
```

### Option 3: Run Specific Test Class

```bash
mvn test -Dtest=FilterAPI
```

### Option 4: Run Tests with TestNG Configuration

```bash
java -cp target/classes:target/test-classes:$M2_REPO/* org.testng.TestNG testng.xml
```

## Test Reports

### TestNG Report (Default)
- Location: `test-output/index.html`
- View in any web browser
- Shows: Pass/Fail results, execution time, test details

### Allure Report

#### Generate Allure Report:
```bash
mvn allure:report
```

#### View Allure Report:
```bash
mvn allure:serve
```

#### Or using Allure CLI:
```bash
# Install Allure (if not installed)
npm install -g allure-commandline

# Generate report
allure generate target/allure-results --clean -o target/allure-report

# Serve report
allure open target/allure-report
```

## Test Classes Overview

### 1. FilterAPI.java
- **Endpoint**: POST `/filters/get_filters`
- **Method**: `testGetFilters()`
- **Purpose**: Test filter API with various filter parameters

### 2. F5Pull0API.java
- **Endpoint**: POST `/f5/pull0`
- **Method**: `testF5Pull0Endpoint()`
- **Purpose**: Test F5 pull0 endpoint

### 3. F5PrePull1API.java
- **Endpoint**: POST `/f5/pre-pull-1`
- **Method**: `testF5PrePull1Endpoint()`
- **Purpose**: Test F5 pre-pull-1 endpoint with complex payload

### 4. F5RunPullAPI.java
- **Endpoint**: POST `/f5/pulls/{pull_number}`
- **Method**: `testRunPull()`
- **Purpose**: Test running specific pull by pull number

### 5. F5CoreBundleAPI.java
- **Endpoint**: POST `/f5/core`
- **Method**: `testRunCoreBundle()`
- **Purpose**: Test F5 core bundle execution

### 6. F5RunModulesAPI.java
- **Endpoint**: POST `/f5/run`
- **Method**: `testRunModules()`
- **Purpose**: Test running specific modules

### 7. F5ProvenanceAPI.java
- **Endpoint**: POST `/f5/provenance`
- **Method**: `testF5Provenance()`
- **Purpose**: Test F5 provenance tracking

### 8. F5ResolveLaddersAPI.java
- **Endpoints**: 
  - GET `/f5/resolve/ladders`
  - POST `/f5/resolve/ladders`
- **Methods**: 
  - `testGetLadders()`
  - `testUpdateLadder()`
- **Purpose**: Test ladder resolution endpoints

### 9. F5ResolveStoreAPI.java
- **Endpoint**: POST `/f5/resolve/store`
- **Method**: `testResolveStoreLadderTerm()`
- **Purpose**: Test store ladder term resolution

### 10. F5ResolveProductAPI.java
- **Endpoint**: POST `/f5/resolve/product`
- **Method**: `testResolveProductLadderTerm()`
- **Purpose**: Test product ladder term resolution

### 11. F5ResolveProductFilterLadderAPI.java
- **Endpoint**: POST `/f5/resolve/product/filter-ladder`
- **Method**: `testGetProductFilterLadder()`
- **Purpose**: Test product filter ladder retrieval

## Configuration

### Base Configuration (APIConstants.java)

```java
- BASE_URI: https://promo-assistant-ai-uat.symphonyretailai.com/api
- USERNAME: promo_diag_svc
- PASSWORD: pD!9xK#mRq2@Lv7nZw$4eY
- TOKEN: ******
```

To change credentials:
1. Edit `src/test/java/utilities/APIConstants.java`
2. Update BASE_URI, USERNAME, PASSWORD, or TOKEN constants
3. Recompile and run tests

### TestNG Configuration (testng.xml)

- Suite Name: API Automation Test Suite
- Parallel Execution: false
- Test Groups: 11 test groups (one per API class)
- Listeners: Allure Test Listener enabled

To add more tests:
1. Create new test class in F5_APIs package
2. Add test group in testng.xml
3. Run tests

## Dependencies

- **REST Assured 5.5.6**: HTTP client library for API testing
- **TestNG 7.11.0**: Test framework
- **Allure TestNG 2.25.0**: Report generation
- **Allure Core 2.25.0**: Core reporting library

## Expected Test Results

All tests are designed to:
- Execute HTTP requests to the configured API endpoints
- Use Basic Authentication with configured credentials
- Send JSON payloads with test data
- Assert HTTP 200 status code response
- Log all requests and responses

**Note**: Tests will pass or fail based on actual API availability and responses.

## Troubleshooting

### Issue: Maven not found
**Solution**: Ensure Maven is installed or use PowerShell script with Java classpath

### Issue: Allure report not generating
**Solution**: Ensure Allure dependencies are downloaded and Allure CLI is installed

### Issue: Test failures
**Solution**: 
1. Verify API endpoint is accessible
2. Check credentials in APIConstants.java
3. Review test output for specific error messages
4. Check network connectivity to the API server

### Issue: Compilation errors
**Solution**:
1. Ensure Java 21+ is installed
