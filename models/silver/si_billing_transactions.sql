{{ config(
    materialized='table'
) }}

with unique_transactions as (
    -- Deduplication logic
    select *,
           row_number() over (partition by transaction_id order by event_date desc) as rn
    from {{ ref('bz_billing_transactions') }}
)
select
    transaction_id,
    customer_id,
    event_date,
    event_type,
    plan_name,
    amount
from unique_transactions
where rn = 1
  and event_type != 'CANCEL'