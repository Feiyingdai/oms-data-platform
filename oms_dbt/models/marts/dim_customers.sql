{{
    config(
        materialized='incremental',
        unique_key='customer_key' 
    )
}}

WITH final_customer AS (
    SELECT
        customer_key, 
        customer_id,
        customer_name,
        city,
        state,
        dbt_valid_from AS valid_from,
        dbt_valid_to AS valid_to,
        dbt_updated_at, 
        CASE 
            WHEN dbt_valid_to IS NULL THEN 1
            ELSE 0
         END AS is_current
    FROM {{ ref('stg_customers') }}
)

SELECT * FROM final_customer

{% if is_incremental() %}
    WHERE dbt_updated_at >= (SELECT COALESCE(MAX(dbt_updated_at), '1900-01-01') FROM {{ this }})
{% endif %}