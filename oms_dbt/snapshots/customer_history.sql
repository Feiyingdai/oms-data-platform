{% snapshot customer_history %}

{{
    config(
        target_schema='snapshots',
        unique_key='CUSTOMERID',
        strategy='timestamp',  
        updated_at='updated_at',
    )
}}

SELECT * FROM {{ source('oms', 'customers') }}

{% endsnapshot %}