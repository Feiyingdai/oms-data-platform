SELECT
    CUSTOMERID       AS customer_id,
    FIRSTNAME        AS first_name,
    LASTNAME         AS last_name,
    EMAIL            AS email,
    PHONE            AS phone,
    ADDRESS          AS address,
    CITY             AS city,
    STATE            AS state,
    ZIPCODE          AS zip_code,
    UPDATED_AT       AS updated_at,
    CONCAT(FIRSTNAME, ' ', LASTNAME) AS customer_name,
    DBT_SCD_ID      AS customer_key,
    DBT_UPDATED_AT   AS dbt_updated_at,
    DBT_VALID_FROM   AS dbt_valid_from,
    DBT_VALID_TO     AS dbt_valid_to
FROM 
    {{ ref('customer_history') }}