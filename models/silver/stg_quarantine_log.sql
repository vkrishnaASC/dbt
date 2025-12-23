{{ config(materialized='incremental', schema='staging') }}

select 
    transaction_id, 
    customer_id, 
    'Overcharge: BASIC plan > $50' as error_reason,
    current_timestamp() as detected_at
from {{ ref('bz_billing_transactions') }}
where plan_name = 'BASIC' and amount > 50