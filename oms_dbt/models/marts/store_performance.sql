    SELECT
        o.store_id,
        SUM(o.revenue) AS actual_revenue,
        SUM(st.sales_target) AS target_revenue
    FROM {{ ref('obt_orders') }} AS o
    JOIN {{ ref('stg_salestargets') }} AS st 
        ON o.store_id = st.store_id
    GROUP BY o.store_id