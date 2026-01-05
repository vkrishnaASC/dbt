{{ config(materialized='incremental') }}

select
    transaction_id,
    customer_id,
    plan_name,
    event_date,
    event_type,
    amount,
    -- Business Logic: Flagging revenue vs. non-revenue events
    case when event_type in ('SUBSCRIPTION_START', 'UPGRADE', 'RENEWAL') then amount else 0 end as gross_revenue,
    case when event_type = 'REFUND' then amount else 0 end as refund_amount
from {{ ref('stg_transactions') }}