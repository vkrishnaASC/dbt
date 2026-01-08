with calendar as (
    select * from {{ ref('dim_date') }}
),
enrollment_data as (
    select * from {{ ref('dim_enrollment_date') }}
),
students as (
    select * from {{ ref('dim_students') }}
),
courses as (
    select * from {{ ref('dim_courses') }}
)

select
    -- We use 'cal' for calendar attributes
    cal.enrollment_date,
    cal.year,
    cal.month_name,
    cal.day_type,
    
    -- We use 'e' for transaction data
    e.student_id,
    e.course_id,
    coalesce(e.credits, 0) as credits,
    
    -- We use 's' for student attributes
    s.current_major,
    
    -- We use 'crs' for course attributes
    crs.course_category
from calendar cal
left join enrollment_data e on cal.enrollment_date = e.enrollment_date
left join students s on e.student_id = s.student_id
left join courses crs on e.course_id = crs.course_id
where e.student_id is not null