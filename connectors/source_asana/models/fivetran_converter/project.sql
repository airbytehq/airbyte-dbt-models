{% if target.type == "snowflake" %}

{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.archived,
            t.created_at,
            t.current_status,
            t.due_date,
            t.modified_at,
            t.name,
            JSON_QUERY(t.owner, '$.gid') as owner_id,
            t.public,
            JSON_QUERY(t.team, '$.gid') as team_id,
            JSON_QUERY(t.workspace, '$.gid') as workspace_id,
            t.notes
        FROM
            {{ source('source_asana', 'projects') }} t
    )
    SELECT * FROM tmp


{% elif target.type == "postgres" %}

{%endif%}