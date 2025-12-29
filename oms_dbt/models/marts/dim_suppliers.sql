{{
    config(
        materialized='incremental',
        unique_key='supplier_key' 
    )
}}

WITH final_supplier AS (
    SELECT
        supplier_key, 
        supplier_id,
        supplier_name,
        city,
        state,
        dbt_valid_from AS valid_from,
        dbt_valid_to AS valid_to,
        dbt_updated_at, 
        CASE 
            WHEN dbt_valid_to IS NULL THEN 1
            ELSE 0
         END AS is_current
    FROM {{ ref('stg_suppliers') }}
)

SELECT * FROM final_supplier

{% if is_incremental() %}
    WHERE dbt_updated_at >= (SELECT COALESCE(MAX(dbt_updated_at), '1900-01-01') FROM {{ this }})
{% endif %}