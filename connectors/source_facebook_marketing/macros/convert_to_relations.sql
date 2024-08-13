{% macro convert_to_relations(source_list) %}
  {% set relations = [] %}
  {% for source_item in source_list %}
    {% set relation = source(source_item['name'], source_item['table']) %}
    {% do relations.append(relation) %}
  {% endfor %}
  {{ return(relations) }}
{% endmacro %}