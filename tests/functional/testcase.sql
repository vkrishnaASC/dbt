-- Test case to verify data quality in si_billing_transactions
-- Tests: No duplicates, no CANCEL events, valid amounts, valid dates

WITH test_results AS (
    SELECT 
        COUNT(*) as total_rows,
        COUNT(DISTINCT transaction_id) as distinct_transaction_count,
        COUNT(CASE WHEN event_type = 'CANCEL' THEN 1 END) as cancel_events,
        COUNT(CASE WHEN amount <= 0 THEN 1 END) as invalid_amounts,
        COUNT(CASE WHEN event_date > CURRENT_DATE() THEN 1 END) as future_dates,
        COUNT(CASE WHEN customer_id IS NULL THEN 1 END) as null_customers
    FROM ASCENDION.BRONZE.si_billing_transactions
)
SELECT 
    CASE 
        WHEN total_rows != distinct_transaction_count THEN 'FAIL: Duplicate transactions found'
        WHEN cancel_events > 0 THEN 'FAIL: CANCEL events present'
        WHEN invalid_amounts > 0 THEN 'FAIL: Invalid amounts found'
        WHEN future_dates > 0 THEN 'FAIL: Future dates found'
        WHEN null_customers > 0 THEN 'FAIL: Null customer IDs found'
        ELSE 'PASS: All checks successful'
    END as test_result
FROM test_results
WHERE total_rows != distinct_transaction_count
    OR cancel_events > 0
    OR invalid_amounts > 0
    OR future_dates > 0
    OR null_customers > 0