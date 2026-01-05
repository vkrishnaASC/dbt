{{ config(materialized='table') }}

with raw_data as (
    select * from {{ ref('stg_transactions') }} -- Assuming your raw data is in a staging model
),
final as (
    select
        customer_id,
        min(event_date) as first_seen_at,
        count(transaction_id) as total_events_to_date
    from raw_data
    group by 1
)
select * from final