{# Note: For improved responses about models, sources, and DAG relationships, please compile your DBT project first. #}

-- Test to identify BASIC plan customers with revenue > $50
SELECT 
    customer_id,
    current_plan,
    total_revenue
FROM {{ ref('fact_customer_revenue') }}
WHERE current_plan = 'BASIC'
    AND total_revenue > 50
ORDER BY total_revenue DESC