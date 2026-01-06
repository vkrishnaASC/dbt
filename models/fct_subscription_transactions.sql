{{ config(materialized='incremental') }}

select
    t.transaction_id,
    t.customer_id,
    t.event_date,
    t.event_type,
    t.amount,
    c.plan_name, -- Joined from staging/snapshot for historical accuracy
    case when t.event_type in ('SUBSCRIPTION_START', 'UPGRADE', 'RENEWAL') then t.amount else 0 end as gross_revenue,
    case when t.event_type = 'REFUND' then t.amount else 0 end as refund_amount
from {{ ref('stg_billing_transactions') }} t
left join {{ ref('stg_customers') }} c
    on t.customer_id = c.customer_id
    and t.event_date >= c.start_at
    and (t.event_date < c.end_at or c.end_at is null)