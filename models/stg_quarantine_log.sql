{# Note: For improved responses about models, sources, and DAG relationships, please compile your DBT project first. #}

-- Without access to fact_customer_revenue.sql columns, adding comment placeholders
{{ config(
    materialized='incremental',
    schema='staging',
) }}

select
    customer_id,
    plan_name,
    amount,
    'Overcharge: BASIC plan > $50' as error_reason,
    transaction_date, -- Assuming this exists for tracking when issue occurred
    current_timestamp() as detected_at
from {{ ref('fact_customer_revenue') }}
where plan_name = 'BASIC' 
  and amount > 50
  {% if is_incremental() %}
  and transaction_date >= (select max(transaction_date) from {{ this }})
  {% endif %}