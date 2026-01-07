select
    e.*,
    s.major as major_at_enrollment
from {{ ref('stg_enrollments') }} e
left join {{ ref('student_history') }} s
    on e.student_id = s.student_id
    and e.enrollment_date >= s.dbt_valid_from
    and (e.enrollment_date < s.dbt_valid_to or s.dbt_valid_to is null)