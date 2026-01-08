with calendar as (
    select * from {{ ref('dim_date') }}
),
enrollment_data as (
    -- Now includes course_id and credits
    select * from {{ ref('dim_enrollment_date') }}
),
students as (
    select * from {{ ref('dim_students') }}
),
courses as (
    select * from {{ ref('dim_courses') }}
)

select
    c.enrollment_date,
    e.student_id,
    e.course_id,
    coalesce(e.credits, 0) as credits,
    s.current_major,
    c.course_category,
    c.year,
    c.month_name,
    c.day_type
from calendar c
left join enrollment_data e on c.enrollment_date = e.enrollment_date
left join students s on e.student_id = s.student_id
left join courses c on e.course_id = c.course_id
where e.student_id is not null