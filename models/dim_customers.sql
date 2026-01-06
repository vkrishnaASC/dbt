{{ config(materialized='table') }}

select
    customer_id,
    plan_name as current_plan,
    min(start_at) over (partition by customer_id) as first_seen_at
from {{ ref('stg_customers') }}
where is_current = true