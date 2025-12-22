
{{ config(materialized='table') }}

-- 1. Identify rows that fail our 'Overcharge' business rule
-- These will be inserted into your QUARANTINE_LOG manually or via a separate script
-- For the demo, we simply filter them out of the main flow
with quarantine_check as (
    select *,
           case 
             when plan_name = 'BASIC' and amount > 50 then 'Overcharge'
             else null 
           end as flag
    from {{ ref('bz_billing_transactions') }}
),

unique_transactions as (
    select * exclude flag,
           row_number() over (
               partition by customer_id, event_date, plan_name, amount 
               order by transaction_id asc
           ) as rn
    from quarantine_check
    where flag is null -- This keeps 'Bad' data out of Silver/Gold
)

select transaction_id, customer_id, event_date, event_type, plan_name, amount
from unique_transactions
where rn = 1 and event_type != 'CANCEL'