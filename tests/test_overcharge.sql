{# Note: For improved responses about models, sources, and DAG relationships, please compile your DBT project first. #}

-- models/tests/assert_basic_plan_revenue_limit.sql
SELECT 
    customer_id,
    current_plan,
    total_revenue
FROM {{ ref('fact_customer_revenue') }}
WHERE current_plan = 'BASIC'
    AND total_revenue > 50