
# OMS Data Transformation (dbt)

This dbt project manages the transformation pipeline for the Order Management System (OMS). It transforms raw data from Snowflake (`OMS.LOADED`) into a star-schema data mart (`OMS.FANNY_DEV_MARTS`) ready for BI analysis.

## 🏗 Architecture & Lineage

The project follows a refined **Medallion Architecture** (Raw -> Staging -> Marts) adapted for modern data warehousing:

1.  **Sources (Raw Layer):**
    * Raw data resides in Snowflake schema `OMS.LOADED`.

2.  **Snapshots (Change Capture):**
    * Captures historical changes from mutable source tables (`employees`, `products`, etc.) using **SCD Type 2** logic.
    * Uses `timestamp` strategy to track validity windows (`dbt_valid_from`, `dbt_valid_to`).

3.  **Staging (Silver Layer - `models/staging`):**
    * Cleans and standardizes raw data (renaming, casting).
    * **Advanced Incremental Logic:** `stg_orders` and `stg_orderitems` are materialized as incremental models to optimize processing of high-volume transactional data.

4.  **Marts (Gold Layer - `models/marts`):**
    * **Dimension Tables (`dim_`):** Built on top of snapshots to provide point-in-time accuracy for historical analysis.
    * **Fact Tables (`fct_`):**
        * `fct_orders`: **Incremental model** that joins incremental staging models to deliver high-performance updates.
    * **One Big Table (`obt_`):**
        * `obt_orders`: A denormalized wide table pre-joining Facts and Dimensions, ready for direct consumption by BI tools (Tableau/PowerBI).

## 🚀 Key Features

* **End-to-End Incremental Loading:**
    * Implements a robust incremental strategy across both Staging and Mart layers.
    * `stg_orders` and `stg_orderitems` utilize **lookback windows** to safely handle late-arriving data and updates.
    * `fct_orders` inherits this incremental logic, ensuring the entire pipeline remains performant as data volume grows.
* **SCD Type 2 History:**
    * Full history tracking for critical dimensions (Customers, Products, Employees) using dbt Snapshots, enabling accurate historical reporting (e.g., "Sales by *Employee's Role at the time of order*").
* **Comprehensive Data Quality Tests:**
    * **Standard Tests:** `unique`, `not_null` constraints on primary keys.
    * **Referential Integrity:** `relationships` tests to ensure Fact tables only reference existing Dimensions.
    * **Business Logic Tests:** Custom checks for data validity (e.g., non-negative prices, valid order status codes).

## 🛠 Prerequisites

* **dbt Core** (v1.8+) or dbt Cloud.
* **Snowflake** account.
* `profiles.yml` configured with a profile named `oms_dbt`.

## ▶️ How to Run

1.  **Install Dependencies:**
    ```bash
    dbt deps
    ```

2.  **Load Seeds (Reference Data):**
    ```bash
    dbt seed
    ```

3.  **Capture Snapshots (SCD Type 2):**
    ```bash
    dbt snapshot
    ```

4.  **Run Models:**
    ```bash
    dbt run
    ```

5.  **Test Data Quality:**
    ```bash
    dbt test
    ```

## 📂 Project Structure

```text
oms_dbt/
├── models/
│   ├── staging/        # View models cleaning raw data
│   └── marts/          # Dimension and Fact tables (Business Logic)
├── snapshots/          # SCD Type 2 logic
├── seeds/              # CSV files (e.g. sales targets)
└── tests/              # Custom tests