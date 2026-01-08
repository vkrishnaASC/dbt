-- This model bridges our staging data to the fact table
select
    student_id,
    course_id,
    enrollment_date,
    credits
from {{ ref('stg_enrollments') }}