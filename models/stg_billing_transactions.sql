select
    transaction_id,
    customer_id,
    event_date,
    event_type,
    plan_name,
    amount
from {{ ref('raw_billing_transactions') }}