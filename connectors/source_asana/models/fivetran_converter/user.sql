{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.name,
            t.email
        FROM
            {{ source('source_asana', 'users') }} t
    )
    SELECT * FROM tmp

{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.name,
            t.email
        FROM
            {{ source('source_asana', 'users') }} t
    )
    SELECT * FROM tmp

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.name,
            t.email
        FROM
            {{ source('source_asana', 'users') }} t
    )
    SELECT * FROM tmp

{%endif%}
