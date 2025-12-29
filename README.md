# OMS Data Platform 🛍️

**An End-to-End Modern Data Stack Project using Snowflake & dbt Core.**

## 📖 Project Overview

This repository hosts the complete data engineering lifecycle for **SleekMart's Order Management System (OMS)**. It demonstrates a full ELT (Extract, Load, Transform) pipeline that processes raw transactional data into a clean, analytical-ready Star Schema and One-Big-Table (OBT) for Business Intelligence consumption.

**Key Technologies:**
* **Data Warehouse:** Snowflake
* **Transformation:** dbt Core (v1.8+)
* **Architecture:** Medallion (Raw -> Staging -> Marts)
* **Modeling:** Kimball Star Schema, SCD Type 2, Incremental Loading

---

## 📂 Repository Structure

This project is organized into two main components representing the Infrastructure and Application layers:

```text
oms-data-platform/
├── db_setup/          # 🏗️ Infrastructure Layer
│   ├── 1_initialize.sql      # Database & Schema creation DDL
│   └── ...                   # Raw data insertion scripts (Simulating EL process)
│
└── oms_dbt/           # ⚙️ Transformation Layer (Application)
    ├── models/               # SQL logic for Staging and Marts
    ├── snapshots/            # SCD Type 2 Logic
    ├── tests/                # Data Quality Checks
    └── dbt_project.yml       # Project Configuration