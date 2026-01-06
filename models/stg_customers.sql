select
    customer_id,
    plan_name,
    dbt_valid_from as start_at,
    dbt_valid_to as end_at,
    (dbt_valid_to is null) as is_current
from {{ ref('users_snapshot') }}