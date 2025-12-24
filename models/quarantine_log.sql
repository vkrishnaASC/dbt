{{ config(
    materialized='incremental',
    schema='staging',
    unique_key='transaction_id'
) }}

with raw_data as (
    select * from {{ ref('raw_billing_transactions') }}
)

select
    transaction_id::int as transaction_id,
    customer_id::varchar as customer_id,
    upper(plan_name) as plan_name,
    amount::decimal(10,2) as amount,
    'Overcharge: BASIC plan > $50' as error_reason,
    event_date::date as transaction_date,
    current_timestamp() as detected_at
from raw_data
where upper(plan_name) = 'BASIC' 
and amount > 50
{% if is_incremental() %}
    and event_date >= (select max(transaction_date) from {{ this }})
{% endif %}