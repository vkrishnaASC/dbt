{# Note: For improved responses about models, sources, and DAG relationships, please compile your DBT project first. #}

-- fact_customer_revenue_basic_plan_check.sql
SELECT 
    customer_id,
    current_plan,
    total_revenue
FROM {{ ref('fact_customer_revenue') }}
WHERE 
    UPPER(current_plan) = 'BASIC'
    AND total_revenue > 50
ORDER BY 
    total_revenue DESC