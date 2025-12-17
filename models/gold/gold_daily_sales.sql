{{ config(
    materialized='table'
) }}

select
    order_date,
    sum(total_amount) as daily_revenue
from {{ ref('silver_orders') }}
group by order_date
