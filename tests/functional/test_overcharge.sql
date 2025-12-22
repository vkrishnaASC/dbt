-- dim_customer_revenue_basic_plan_revenue_check.sql
with basic_plan_customers as (
    select 
        dcr.customer_id,
        dcr.net_lifetime_revenue,
        bt.plan_name
    from {{ ref('dim_customer_revenue') }} dcr
    inner join {{ ref('si_billing_transactions') }} bt
        on dcr.customer_id = bt.customer_id
    where bt.plan_name = 'BASIC'
        and dcr.net_lifetime_revenue > 50
    qualify row_number() over (partition by dcr.customer_id order by bt.event_date desc) = 1
)
select 
    customer_id,
    net_lifetime_revenue,
    plan_name
from basic_plan_customers