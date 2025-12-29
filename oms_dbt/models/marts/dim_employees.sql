{{
    config(
        materialized='incremental',
        unique_key='employee_key' 
    )
}}

WITH final_employee AS (
    SELECT
        employee_key, 
        employee_id,
        employee_name,
        city,
        state,
        job_title,
        manager_id,
        dbt_valid_from AS valid_from,
        dbt_valid_to AS valid_to,
        dbt_updated_at, 
        CASE 
            WHEN dbt_valid_to IS NULL THEN 1
            ELSE 0
         END AS is_current
    FROM {{ ref('stg_employees') }}
)

SELECT * FROM final_employee

{% if is_incremental() %}
    WHERE dbt_updated_at >= (SELECT COALESCE(MAX(dbt_updated_at), '1900-01-01') FROM {{ this }})
{% endif %}