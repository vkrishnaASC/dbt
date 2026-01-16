{% macro auto_standard_tests(column_name) %}
    {% set tests = [] %}
    {% set col = column_name.lower() %}

    {# RULE 1: Identity Columns #}
    {% if col == 'id' or col.endswith('_id') or col.endswith('_key') %}
        {% do tests.append('not_null') %}
        {% do tests.append('unique') %}

    {# RULE 2: Timestamps #}
    {% elif col.endswith('_at') or col.endswith('_ts') or col.endswith('_time') %}
        {% do tests.append('not_null') %}

    {# RULE 3: Financial/Amount Columns #}
    {% elif col.endswith('_amount') or col.endswith('_amt') or col.endswith('_price') or col.endswith('_balance') %}
        {% do tests.append('not_negative') %}

    {# RULE 4: Boolean/Flag Columns #}
    {% elif col.startswith('is_') or col.startswith('has_') %}
        {% do tests.append({'accepted_values': {'values': [true, false]}}) %}

    {# RULE 5: Specific Overrides (Only for things that don't follow patterns) #}
    {% else %}
        {% set manual_overrides = {
            'status': [{'accepted_values': {'values': ['active', 'inactive', 'pending']}}],
            'email': ['assert_valid_email']
        } %}
        
        {% if col in manual_overrides %}
            {% set tests = manual_overrides[col] %}
        {% endif %}
    {% endif %}

    {{ return(tests) }}
{% endmacro %}
