with enrollment_data as (
    select * from {{ ref('stg_enrollments') }}
),
students as (
    select * from {{ ref('dim_students') }}
),
courses as (
    select * from {{ ref('dim_courses') }}
)
select
    e.student_id,
    e.course_id,
    e.enrollment_date,
    e.credits,
    s.current_major,        -- Sourced from dim_students
    c.course_category       -- Sourced from dim_courses
from enrollment_data e
left join students s on e.student_id = s.student_id
left join courses c on e.course_id = c.course_id