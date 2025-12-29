# OMS Database Setup
This repository contains SQL scripts to set up the Order Management System (OMS) database in Snowflake.

**Datasource:** SleekData (Modified for dbt training purposes).

## File Overview

### 1_initialize.sql
Creates the `OMS` database, the `LOADED` schema (where raw data resides), and defines the table structures (DDL) for all required tables.
**Note:** Run this script first to ensure the destination environment exists.

### 2_customers_insert.sql
Populates the `CUSTOMERS` table with sample customer data (Names, Addresses, Contact info).

### 3_employees_insert.sql
Populates the `EMPLOYEES` table with employee records (Names, Job Titles, Manager IDs).

### 4_products_insert.sql
Populates the `PRODUCTS` table with product catalog data (Product Names, Categories, Prices).

### 5_orderitems_insert.sql
Populates the `ORDERITEMS` table. This is the transactional detail table linking Orders to Products (Quantity, Unit Price).

### 6_orders_insert.sql
Populates the `ORDERS` table. This is the transactional header table containing Order IDs, Dates, Customer IDs, and Employee IDs.

### 7_stores_insert.sql
Populates the `STORES` table with physical store location data.

### 8_suppliers_insert.sql
Populates the `SUPPLIERS` table with supplier information linked to products.

---

## How to Execute

To set up the database in your Snowflake environment, follow these steps:

1.  **Login to Snowflake:** Open your Snowflake Snowsight interface.
2.  **Open Worksheets:** Create a new SQL Worksheet.
3.  **Run in Sequence:** Copy and paste the content of the scripts and execute them in the following order to ensure dependencies are met:

    1.  `1_initialize.sql` (Critical: Must be first)
    2.  `2_customers_insert.sql`
    3.  `3_employees_insert.sql`
    4.  `7_stores_insert.sql`
    5.  `8_suppliers_insert.sql`
    6.  `4_products_insert.sql`
    7.  `6_orders_insert.sql`
    8.  `5_orderitems_insert.sql`


4.  **Verify:** After execution, verify the data using:
    ```sql
    SELECT COUNT(*) FROM OMS.LOADED.CUSTOMERS;
    -- Repeat for other tables
    ```

## Data Schema (Raw Layer)

All data is loaded into:
* **Database:** `OMS`
* **Schema:** `LOADED`

**Tables:**
* `CUSTOMERS`
* `EMPLOYEES`
* `STORES`
* `SUPPLIERS`
* `PRODUCTS`
* `ORDERS`
* `ORDERITEMS`