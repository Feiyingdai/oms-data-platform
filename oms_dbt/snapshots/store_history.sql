{% snapshot store_history %}

{{
    config(
        target_schema='snapshots',
        unique_key='STOREID',
        strategy='timestamp',  
        updated_at='updated_at',
    )
}}

SELECT * FROM {{ source('oms', 'stores') }}

{% endsnapshot %}