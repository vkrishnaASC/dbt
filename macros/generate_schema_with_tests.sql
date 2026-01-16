{% macro generate_schema_with_tests(model_name) %}

{% set columns = adapter.get_columns_in_relation(ref(model_name)) %}

{% set yaml_output = [] %}
{% do yaml_output.append("version: 2") %}
{% do yaml_output.append("models:") %}
{% do yaml_output.append("  - name: " ~ model_name) %}
{% do yaml_output.append("    columns:") %}

{% for col in columns %}
    {% do yaml_output.append("      - name: " ~ col.name) %}
    
    {# Fetch tests from our rules engine #}
    {% set tests = auto_standard_tests(col.name) %}
    
    {% if tests | length > 0 %}
        {% do yaml_output.append("        data_tests:") %}
        {% for test in tests %}
            {% if test is mapping %}
                {# Handle tests with arguments like accepted_values #}
                {% for test_name, args in test.items() %}
                    {% do yaml_output.append("          - " ~ test_name ~ ":") %}
                    {% for arg_name, arg_val in args.items() %}
                        {% do yaml_output.append("              " ~ arg_name ~ ": " ~ arg_val) %}
                    {% endfor %}
                {% endfor %}
            {% else %}
                {% do yaml_output.append("          - " ~ test) %}
            {% endif %}
        {% endfor %}
    {% endif %}
{% endfor %}

{# Print the final YAML to the console #}
{% do log(yaml_output | join('\n'), info=True) %}

{% endmacro %}