{{
    config(
        materialized='incremental',
        unique_key=['order_id', 'order_item_id']
    )
}}
SELECT
    ORDERID        AS order_id,
    ORDERITEMID    AS order_item_id,
    PRODUCTID      AS product_id,
    QUANTITY       AS quantity,
    UNITPRICE      AS unit_price,
    QUANTITY * UNITPRICE AS total_price,
    UPDATED_AT     AS updated_at
FROM
    {{ source('oms', 'orderitems') }}

{% if is_incremental() %}
WHERE updated_at >= (
    SELECT DATEADD(HOUR, -24, MAX(updated_at)) FROM {{ this }}
)
{% endif %}