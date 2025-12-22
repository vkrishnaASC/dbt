{{ config(
    materialized='table'
) }}

select
    customer_id,
    sum(amount) as net_lifetime_revenue,
    count(transaction_id) as total_active_transactions
from {{ ref('si_billing_transactions') }}
group by 1