{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            p.value::STRING AS project_id,
            cast(json_value(t, "$.gid") as {{ dbt.type_string() }}) AS task_id
        FROM
            {{ source('source_asana', 'tasks') }} t,
            LATERAL FLATTEN(input => PARSE_JSON(t.projects)) p
    )
    SELECT * FROM tmp
    WHERE project_id IS NOT NULL

{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            cast(t.gid as {{ dbt.type_string() }}) as task_id,
            cast(json_value(p, "$.gid") as {{ dbt.type_string() }}) as project_id
        FROM
            {{ source('source_asana', 'tasks') }} t,
            UNNEST(JSON_EXTRACT_ARRAY(t.projects)) AS p
    )
    SELECT * FROM tmp
    WHERE project_id IS NOT NULL

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            (p.value->>'gid') AS project_id,
            t.gid AS task_id
        FROM
            {{ source('source_asana', 'tasks') }} t,
            LATERAL jsonb_array_elements(t.projects::jsonb) AS p(value)
    )
    SELECT * FROM tmp
    WHERE project_id IS NOT NULL

{%endif%}
