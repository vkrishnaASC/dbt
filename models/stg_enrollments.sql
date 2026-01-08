select
    student_id,
    course_id,
    course_name,
    -- Cleaning: Ensuring credits is always a float for math
    cast(credits as float) as credits,
    enrollment_date,
    major
from {{ ref('raw_enrollments') }}