{# Note: For improved responses about models, sources, and DAG relationships, please compile your DBT project first. #}

-- fact_customer_revenue_basic_plan_check.sql
SELECT 
    customer_id,
    current_plan,
    net_lifetime_revenue
FROM {{ ref('fact_customer_revenue') }}
WHERE 
    UPPER(current_plan) = 'BASIC'
    AND net_lifetime_revenue > 50
ORDER BY 
    net_lifetime_revenue DESC