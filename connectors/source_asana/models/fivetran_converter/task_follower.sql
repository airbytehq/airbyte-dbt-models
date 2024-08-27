{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            t.gid AS task_id,
            f.value::STRING AS user_id
        FROM
            {{ source('source_asana', 'tasks') }} t,
            LATERAL FLATTEN(input => PARSE_JSON(t.followers)) f
    )
    SELECT * FROM tmp
    WHERE user_id IS NOT NULL


{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            t.gid as task_id,
            f.gid as user_id,
        FROM
            {{ source('source_asana', 'tasks') }} t,
            UNNEST(JSON_EXTRACT_ARRAY(t.followers)) AS f
    )
    SELECT * FROM tmp
    WHERE user_id IS NOT NULL

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            t.gid AS task_id,
            (f.value->>'gid') AS user_id
        FROM
            {{ source('source_asana', 'tasks') }} t,
            LATERAL jsonb_array_elements(t.followers::jsonb) AS f(value)
    )
    SELECT * FROM tmp
    WHERE user_id IS NOT NULL

{%endif%}
