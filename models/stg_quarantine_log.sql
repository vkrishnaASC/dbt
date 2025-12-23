{{ config(
    materialized='incremental',
    schema='staging',
    unique_key='transaction_id'
) }}

select
    transaction_id,
    customer_id,
    plan_name,
    amount,
    'Overcharge: BASIC plan > $50' as error_reason,
    event_date as transaction_date, 
    current_timestamp() as detected_at
from {{ ref('raw_billing_transactions') }}  -- Point to RAW, not the Fact
where plan_name = 'BASIC' 
  and amount > 50

{% if is_incremental() %}
  -- This ensures we only add new bad records in future runs
  and event_date >= (select max(transaction_date) from {{ this }})
{% endif %}