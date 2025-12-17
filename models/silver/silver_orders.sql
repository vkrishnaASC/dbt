{{ config(
    materialized='table'
) }}

select
    order_id,
    customer_id,
    order_date,
    status,
    quantity,
    unit_price,
    quantity * unit_price as total_amount
from {{ ref('bronze_orders') }}
where status != 'CANCELLED'
