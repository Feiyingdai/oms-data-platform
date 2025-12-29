{% snapshot product_history %}

{{
    config(
        target_schema='snapshots',
        unique_key='PRODUCTID',
        strategy='timestamp',  
        updated_at='updated_at',
    )
}}

SELECT * FROM {{ source('oms', 'products') }}

{% endsnapshot %}