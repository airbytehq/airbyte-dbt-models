{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.created_at,
            t.created_by:gid::STRING as created_by_id,
            t.task:gid::STRING as target_id,
            t.text,
            t.type
        FROM
            {{ source('source_asana', 'stories') }} t
    )
    SELECT * FROM tmp

{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.created_at,
            cast(JSON_VALUE(t.created_by, '$.gid') as {{ dbt.type_string() }}) as created_by_id,
            cast(JSON_VALUE(t.task, '$.gid') as {{ dbt.type_string() }}) as target_id,
            t.text,
            t.type
        FROM
            {{ source('source_asana', 'stories') }} t
    )
    SELECT * FROM tmp

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.created_at,
            t.created_by->>'gid' as created_by_id,
            t.task->>'gid' as target_id,
            t.text,
            t.type
        FROM
            {{ source('source_asana', 'stories') }} t
    )
    SELECT * FROM tmp

{%endif%}
