{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

SELECT
    ORDERID        AS order_id,
    ORDERDATE      AS order_date,
    CUSTOMERID     AS customer_id,
    EMPLOYEEID     AS employee_id,
    STOREID        AS store_id,
    STATUS         AS status_cd,
    CASE
        WHEN STATUS = '01' THEN 'In Progress'
        WHEN STATUS = '02' THEN 'Completed'
        WHEN STATUS = '03' THEN 'Cancelled'
        ELSE NULL
    END AS status_desc,
    CASE
        WHEN STOREID = 1000 THEN 'Online'
        ELSE 'In-store'
    END AS order_channel,
    UPDATED_AT     AS updated_at
FROM
    {{ source('oms', 'orders') }}

{% if is_incremental() %}
WHERE updated_at >= (
    SELECT DATEADD(HOUR, -24, MAX(updated_at)) FROM {{ this }}
)
{% endif %}