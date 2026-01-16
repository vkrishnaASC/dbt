select distinct
    course_id,
    course_name,
    case 
        when course_id like 'CS%' then 'Technology'
        else 'General Education'
    end as course_category
from {{ ref('stg_enrollments') }}