{% snapshot supplier_history %}

{{
    config(
        target_schema='snapshots',
        unique_key='SUPPLIERID',
        strategy='timestamp',  
        updated_at='updated_at',
    )
}}

SELECT * FROM {{ source('oms', 'suppliers') }}

{% endsnapshot %}