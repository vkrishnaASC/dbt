-- Test case for billing_transactions model
SELECT 
    CASE 
        WHEN COUNT(*) > 0 
        AND MIN(total_revenue) >= 0 
        AND MIN(total_transactions) > 0 
        AND COUNT(DISTINCT customer_id) = COUNT(*) -- Ensure unique customers
        AND NOT EXISTS (
            SELECT 1 
            FROM billing_transactions 
            WHERE current_plan IS NULL
            OR customer_id IS NULL
        )
    THEN 'PASS'
    ELSE 'FAIL'
    END AS test_result,
    COUNT(*) as total_rows,
    COUNT(DISTINCT customer_id) as unique_customers,
    MIN(total_revenue) as min_revenue,
    MAX(total_revenue) as max_revenue,
    MIN(total_transactions) as min_transactions,
    MAX(total_transactions) as max_transactions
FROM billing_transactions