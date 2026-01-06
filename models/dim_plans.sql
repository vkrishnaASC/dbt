{{ config(materialized='table') }}

select distinct
    plan_name,
    case 
        when plan_name = 'BASIC' then 'Entry Level'
        when plan_name = 'PRO' then 'Professional'
        when plan_name = 'PREMIUM' then 'Enterprise'
    end as plan_tier
from {{ ref('raw_billing_transactions') }}