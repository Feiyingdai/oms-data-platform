SELECT
    StoreID AS store_id,
    SalesTarget AS sales_target
FROM {{ ref('salestargets') }}