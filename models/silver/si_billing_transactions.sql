{{ config(
    materialized='table'
) }}

  with unique_transactions as (
    select *,
           -- We partition by everything EXCEPT the ID to find identical rows
           row_number() over (
               partition by customer_id, event_date, plan_name, amount 
               order by transaction_id asc
           ) as rn
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