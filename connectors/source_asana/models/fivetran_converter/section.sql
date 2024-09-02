{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.created_at,
            t.name,
            t.project:gid::STRING as project_id
        FROM
            {{ source('source_asana', 'sections') }} t
    )
    SELECT * FROM tmp

{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.created_at,
            name,
            cast(json_value(t.project, '$.gid') as {{ dbt.type_string() }}) as project_id
        FROM
            {{ source('source_asana', 'sections') }} t
    )
    SELECT * FROM tmp

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.created_at,
            t.name,
            t.project->>'gid' as project_id
        FROM
            {{ source('source_asana', 'sections') }} t
    )
    SELECT * FROM tmp

{%endif%}
