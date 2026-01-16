{% macro generate_bulk_schema(model_names) %}
  
  {# Start the YAML output #}
  {% set yaml_output = ["version: 2", "models:"] %}

  {% for model_name in model_names %}
    {% do yaml_output.append("  - name: " ~ model_name) %}
    {% do yaml_output.append("    columns:") %}

    {# Get columns for this specific model #}
    {% set columns = adapter.get_columns_in_relation(ref(model_name)) %}

    {% for col in columns %}
        {% do yaml_output.append("      - name: " ~ col.name) %}
        
        {% set tests = get_standard_tests(col.name) %}
        
        {% if tests | length > 0 %}
            {% do yaml_output.append("        data_tests:") %}
            {% for test in tests %}
                {% if test is mapping %}
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
  {% endfor %}

  {# Print everything at once #}
  {% do log(yaml_output | join('\n'), info=True) %}

{% endmacro %}