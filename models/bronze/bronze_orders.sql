{{ config(
    materialized='table'
) }}

select
    order_id,
    customer_id,
    order_date,
    status,
    quantity,
    unit_price
from {{ ref('raw_orders') }}
