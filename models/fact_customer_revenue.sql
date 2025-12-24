{{ config(materialized='table') }}

with raw_data as (
    select * from {{ ref('raw_billing_transactions') }}
),

select 
    customer_id,
    max(plan_name) as current_plan,
    sum(amount) as total_revenue,
    count(transaction_id) as total_transactions,
    current_timestamp() as last_updated_at
from cleaned_data
group by 1


