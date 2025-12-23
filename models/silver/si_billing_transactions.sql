{{ config(materialized='table') }}

with unique_transactions as (
    select *,
           row_number() over (
               partition by customer_id, event_date, plan_name, amount 
               order by transaction_id asc
           ) as rn
    from {{ ref('bz_billing_transactions') }}
    -- Filter out the bad data so it never reaches Gold
    where not (plan_name = 'BASIC' and amount > 50)
)
select transaction_id, customer_id, event_date, event_type, plan_name, amount
from unique_transactions
where rn = 1 and event_type != 'CANCEL'