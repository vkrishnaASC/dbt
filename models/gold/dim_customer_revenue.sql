{{ config(
    materialized='table'
) }}

with latest_plan as (
    select 
        customer_id,
        plan_name,
        row_number() over (partition by customer_id order by event_date desc) as rn
    from {{ ref('si_billing_transactions') }}
)
select
    t.customer_id,
    lp.plan_name as current_plan_name,
    sum(t.amount) as net_lifetime_revenue,
    count(t.transaction_id) as total_active_transactions
from {{ ref('si_billing_transactions') }} t
left join latest_plan lp 
    on t.customer_id = lp.customer_id 
    and lp.rn = 1
group by 1, 2