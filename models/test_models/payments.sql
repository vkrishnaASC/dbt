{{ config(materialized='table') }}

select
  10 as payment_id,
  'T1' as tenant_id,
  100 as payment_amount,
  current_timestamp as created_at,
  'SUCCESS' as payment_status
