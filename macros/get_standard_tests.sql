{% macro get_standard_tests(column_name) %}
    {# Define the mapping of column names to tests #}
    {% set mapping = {
        'order_id': ['unique', 'not_null'],
        'payment_id': ['unique', 'not_null'],
        'customer_id': ['unique', 'not_null'],
        'tenant_id': ['not_null'],
        'order_amount': ['not_negative'],
        'payment_amount': ['not_negative'],
        'status': [{'accepted_values': {'values': ['COMPLETED', 'CANCELLED']}}],
        'created_at': ['not_null']
    } %}

    {{ return(mapping.get(column_name.lower(), [])) }}
{% endmacro %}