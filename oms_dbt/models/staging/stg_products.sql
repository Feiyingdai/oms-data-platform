SELECT
    PRODUCTID        AS product_id,
    NAME             AS product_name,
    CATEGORY         AS category,
    RETAILPRICE      AS retail_price,
    SUPPLIERPRICE    AS supplier_price,
    SUPPLIERID       AS supplier_id,
    UPDATED_AT       AS updated_at,
    DBT_SCD_ID       AS product_key,
    DBT_UPDATED_AT   AS dbt_updated_at,
    DBT_VALID_FROM   AS dbt_valid_from,
    DBT_VALID_TO     AS dbt_valid_to
FROM 
    {{ ref('product_history') }}