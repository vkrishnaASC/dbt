{% snapshot users_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='customer_id',
      strategy='check',
      check_cols=['plan_name'],
    )
}}

select 
    customer_id,
    plan_name
from {{ ref('raw_billing_transactions') }}

{% endsnapshot %}