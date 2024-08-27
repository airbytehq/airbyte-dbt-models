{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            t.gid AS task_id,
            tg.value::STRING AS tag_id
        FROM
            {{ source('source_asana', 'tasks') }} t,
            LATERAL FLATTEN(input => PARSE_JSON(t.tags)) tg
    )
    SELECT * FROM tmp
    WHERE tag_id IS NOT NULL

{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            t.gid as task_id,
            tg.gid as tag_id
        FROM
            {{ source('source_asana', 'tasks') }} t,
            UNNEST(JSON_EXTRACT_ARRAY(t.tags)) AS tg
    )
    SELECT * FROM tmp
    WHERE tag_id IS NOT NULL

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            t.gid AS task_id,
            (tg.value->>'gid') AS tag_id
        FROM
            {{ source('source_asana', 'tasks') }} t,
            LATERAL jsonb_array_elements(t.tags::jsonb) AS tg(value)
    )
    SELECT * FROM tmp
    WHERE tag_id IS NOT NULL

{%endif%}
