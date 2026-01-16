{{ config(materialized='table') }}

select
  1 as order_id,
  'T1' as tenant_id,
  100 as order_amount,
  current_timestamp as created_at,
  'COMPLETED' as status
