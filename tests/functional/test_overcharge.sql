-- Test to identify BASIC plan customers with revenue exceeding $50
{# Test case explanation:
This query tests the dim_customer_revenue model by:
1. Filtering for customers on the 'BASIC' plan only
2. Including only customers who have spent more than $50 lifetime
3. Returns key metrics: customer ID, current plan, total revenue, and transaction count
This would be useful for validating revenue assumptions about BASIC plan customers
and ensuring the data quality of high-value BASIC customers.
#}
select 
    customer_id,
    current_plan_name,
    net_lifetime_revenue,
    total_active_transactions
from {{ ref('dim_customer_revenue') }}
where current_plan_name = 'BASIC'
    and net_lifetime_revenue > 50.00