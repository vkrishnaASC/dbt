select
    student_id,
    course_id,
    department,
    credits,
    enrollment_date
from {{ ref('raw_enrollments') }}