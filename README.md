# SauceDemo Robot Framework Test Suite

This project uses Robot Framework to automate the testing of the [Sauce Demo](https://www.saucedemo.com) website.

---

### Key Directories

- **config**  
  Holds configuration files, e.g. `reqres_config.robot` for API endpoints and variables.

- **resources**  
  Contains shared keywords and variables organized into subfolders:

  - **commons/keywords**: Reusable UI keywords (e.g., `browser_keywords.robot`, `login_keyword.robot`).
  - **commons/variables**: Global variables used across test suites.
  - **keywords**: Page-specific Robot files (e.g., `login_page.robot`, `products_page.robot`, etc.).
  - **variables**: Page-specific or feature-specific locator variables and text.

- **tests**  
  Organized by domain (e.g., `ui` vs `api`). Under **ui**, tests are further grouped by feature or flow:

  - **smoke**: Smoke test suite (`smoke_test_ui.robot`).
  - **products**, **auth**, **checkout**, **cart**: Feature-specific Robot files.
  - **api**: Tests for the ReqRes service in `reqres_api.robot`.

- **libraries**  
  Contains Python custom libraries for usage within Robot test suites.

- **scripts**  
  Contains shell scripts for running tests:

  - `run_tests.sh`: Runs all tests.
  - `run_smoke.sh`: Runs only the smoke tests.

- **data**  
  Holds test data files, such as JSON files (`product_list.json`) or CSV files (`invalid_account.csv`).

---

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd saucedemo-robot-framework
   ```
2. **Create a Virtual Environment**
   ```bash
   python -m venv venv
   source venv/bin/activate
   ```
3. **Install Dependencies**
   ```bash
    pip install -r requirements.txt
   ```
4. **Run Tests**
   run all tests
   ```bash
   ./scripts/run_tests.sh
   ```
   run smoke tests
   ```bash
   ./scripts/run_smoke_tests.sh
   ```
   run parallel tests
   ```bash
     ./scripts/run_parallel_tests.sh
   ```
5. **Deactivate Virtual Environment**
   ```bash
   deactivate
   ```
