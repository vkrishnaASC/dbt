{% macro generate_folder_schema(folder_path) %}
  {% set model_names = [] %}
  
  {% for node in graph.nodes.values() %}
    {# Filter for models that are in the specified folder path #}
    {% if node.resource_type == 'model' and folder_path in node.original_file_path %}
      {% do model_names.append(node.name) %}
    {% endif %}
  {% endfor %}

  {{ generate_bulk_schema(model_names) }}
{% endmacro %}