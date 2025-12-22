{{ config(
    materialized='table'
) }}

select
    transaction_id::int as transaction_id,
    customer_id::varchar as customer_id,
    event_date::date as event_date,
    upper(event_type) as event_type,
    upper(plan_name) as plan_name,
    amount::decimal(10,2) as amount
from {{ ref('raw_billing_transactions') }}