SELECT
    SUPPLIERID       AS supplier_id,
    SUPPLIERNAME     AS supplier_name,
    CONTACTPERSON    AS contact_person,
    EMAIL            AS email,
    PHONE            AS phone,
    ADDRESS          AS address,
    CITY             AS city,
    STATE            AS state,
    ZIPCODE          AS zip_code,
    UPDATED_AT       AS updated_at,
    DBT_SCD_ID      AS supplier_key,
    DBT_UPDATED_AT   AS dbt_updated_at,
    DBT_VALID_FROM   AS dbt_valid_from,
    DBT_VALID_TO     AS dbt_valid_to
FROM 
    {{ ref('supplier_history') }}