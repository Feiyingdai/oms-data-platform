{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

-- 1. Identity changed order_ids
-- Use macro to set incremental filter
{% set incremental_filter %}
  {% if is_incremental() %}
    WHERE updated_at >= (SELECT DATEADD(HOUR, -24, MAX(updated_at)) FROM {{ this }})
  {% endif %}
{% endset %}

-- Identity changed order_ids from both source tables
WITH changed_order_ids AS (
    SELECT order_id
    FROM {{ ref('stg_orders') }}
    {{ incremental_filter }}
    UNION 
    SELECT order_id
    FROM {{ ref('stg_orderitems') }}
    {{ incremental_filter }}
),

-- 2. Limit stg_orders scan range
orders_incremental AS (
    SELECT *
    FROM {{ ref('stg_orders') }} 
    INNER JOIN changed_order_ids USING(order_id)
),

-- 3. Limit stg_orderitems scan range
orderitems_incremental AS (
    SELECT *
    FROM {{ ref('stg_orderitems') }} 
    INNER JOIN changed_order_ids USING(order_id)
),

-- 4. Aggregate orderitems to get revenue per order
orders_revenue AS (
    SELECT
        order_id,
        SUM(total_price) as revenue,
        MAX(updated_at) as updated_at
    FROM orderitems_incremental
    GROUP BY order_id
)

SELECT
    o.order_id,
    o.order_date,
    o.customer_id,
    o.employee_id,
    o.store_id,
    o.status_cd,
    o.status_desc,
    GREATEST(o.updated_at, COALESCE(ore.updated_at,o.updated_at)) AS updated_at,
    COALESCE(ore.revenue, 0) as revenue 
FROM orders_incremental o
LEFT JOIN orders_revenue ore ON o.order_id = ore.order_id