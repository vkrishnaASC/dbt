{{ config(materialized='table') }}

with date_spine as (
    -- This is your "Calendar" source
    select * from {{ ref('metricflow_time_spine') }}
)

select
    date_day as enrollment_date, -- Primary Key for the date dimension
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    to_char(date_day, 'Month') as month_name,
    extract(quarter from date_day) as quarter,
    -- Business logic to identify peak enrollment periods (e.g., Weekends)
    case 
        when extract(isodow from date_day) in (6, 7) then 'Weekend' 
        else 'Weekday' 
    end as day_type
from date_spine