SELECT
    EMPLOYEEID      AS employee_id,
    FIRSTNAME       AS first_name,
    LASTNAME        AS last_name,
    EMAIL           AS email,
    JOBTITLE        AS job_title,
    HIREDATE        AS hire_date,
    MANAGERID       AS manager_id,
    ADDRESS         AS address,
    CITY            AS city,
    STATE           AS state,
    ZIPCODE         AS zip_code,
    CONCAT(FIRSTNAME, ' ', LASTNAME) AS employee_name,
    UPDATED_AT      AS updated_at,
    DBT_SCD_ID      AS employee_key,
    DBT_UPDATED_AT   AS dbt_updated_at,
    DBT_VALID_FROM   AS dbt_valid_from,
    DBT_VALID_TO     AS dbt_valid_to
FROM
    {{ ref('employee_history') }}