{{ config(materialized='table') }}

with raw_data as (
    select * from {{ ref('raw_billing_transactions') }}
),

-- Step 1: Clean & Filter (The "Good" data)
cleaned_data as (
    select 
        transaction_id::int as transaction_id,
        customer_id::varchar as customer_id,
        event_date::date as event_date,
        upper(plan_name) as plan_name,
        amount::decimal(10,2) as amount
    from raw_data
)

-- Step 2: Final Aggregation for the Client
select 
    customer_id,
    max(plan_name) as current_plan,
    sum(amount) as total_revenue,
    count(transaction_id) as total_transactions,
    current_timestamp() as last_updated_at
from cleaned_data
group by 1
