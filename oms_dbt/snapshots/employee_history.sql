{% snapshot employee_history %}

{{
    config(
        target_schema='snapshots',
        unique_key='EMPLOYEEID',
        strategy='timestamp',  
        updated_at='updated_at',
    )
}}

SELECT * FROM {{ source('oms', 'employees') }}

{% endsnapshot %}