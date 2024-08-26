{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.name,
            NULL AS created_at --TODO: add created_at on source-asana
        FROM
            {{ source('source_asana', 'tags') }} t
    )
    SELECT * FROM tmp

{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.name,
            NULL AS created_at --TODO: add created_at on source-asana
        FROM
            {{ source('source_asana', 'tags') }} t
    )
    SELECT * FROM tmp

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.name,
            NULL AS created_at --TODO: add created_at on source-asana
        FROM
            {{ source('source_asana', 'tags') }} t
    )
    SELECT * FROM tmp

{%endif%}
