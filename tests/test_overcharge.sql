{# Note: For improved responses about models, sources, and DAG relationships, please compile your DBT project first. #}

SELECT 
    customer_id,
    plan_type,
    net_lifetime_revenue
FROM {{ ref('fact_customer_revenue') }}  -- Replace with actual model name
WHERE 
    UPPER(plan_type) = 'BASIC'
    AND net_lifetime_revenue > 50
HAVING COUNT(*) = 0  -- Test fails if any rows are found