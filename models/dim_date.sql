{{ config(materialized='table') }}

with date_spine as (
    select * from {{ ref('metricflow_time_spine') }}
)

select
    date_day as enrollment_date, 
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    -- to_char is fine in Snowflake for month names
    to_char(date_day, 'MMMM') as month_name, 
    extract(quarter from date_day) as quarter,
    -- FIXED: dayofweekiso() returns 1 (Monday) to 7 (Sunday)
    case 
        when dayofweekiso(date_day) in (6, 7) then 'Weekend' 
        else 'Weekday' 
    end as day_type
from date_spine