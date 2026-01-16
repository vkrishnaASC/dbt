select
    student_id,
    major as current_major,
    dbt_valid_from as record_start,
    dbt_valid_to as record_end
from {{ ref('student_snapshot') }}