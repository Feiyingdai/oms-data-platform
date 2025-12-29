{{
    config(
        materialized='table' 
    )
}}

SELECT
    --1. fct_orders columns
    o.order_id,
    o.order_date,
    o.revenue,
    o.status_desc,
    --2. dim_customers columns
    o.customer_id,
    c.customer_key, 
    c.customer_name,
    c.city AS customer_city,
    c.state AS customer_state,
    -- 3. dim_employees columns
    o.employee_id,
    e.employee_key,
    e.employee_name,
    e.job_title,
    e.city AS employee_city,
    e.state AS employee_state,
    --4. dim_stores columns
    o.store_id,
    s.store_key,
    s.store_name,
    s.city AS store_city,
    s.state AS store_state
FROM {{ ref('fct_orders') }} AS o
LEFT JOIN {{ ref('dim_customers') }} AS c
    ON o.customer_id = c.customer_id
    AND o.order_date >= c.valid_from
    AND (o.order_date < c.valid_to OR c.valid_to IS NULL)
LEFT JOIN {{ ref('dim_employees') }} AS e
    ON o.employee_id = e.employee_id
    AND o.order_date >= e.valid_from
    AND (o.order_date < e.valid_to OR e.valid_to IS NULL)
LEFT JOIN {{ ref('dim_stores') }} AS s
    ON o.store_id = s.store_id
    AND o.order_date >= s.valid_from
    AND (o.order_date < s.valid_to OR s.valid_to IS NULL)