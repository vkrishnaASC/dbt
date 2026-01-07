select
    student_id,
    major as current_major,
    dbt_valid_from as started_at,
    dbt_valid_to as ended_at
from {{ ref('student_history') }}