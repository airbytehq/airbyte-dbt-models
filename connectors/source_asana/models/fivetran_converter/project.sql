{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.archived,
            t.created_at,
            t.current_status,
            t.due_date,
            t.modified_at,
            t.name,
            t.owner:gid::STRING as owner_id,
            t.public,
            t.team:gid::STRING as team_id,
            t.workspace:gid::STRING as workspace_id,
            t.notes
        FROM
            {{ source('source_asana', 'projects') }} t
    )
    SELECT * FROM tmp

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
            cast(json_value(t.owner, '$.gid') as {{dbt.type_string()}}) as owner_id,
            t.public,
            cast(json_value(t.team, '$.gid') as {{dbt.type_string()}}) as team_id,
            cast(json_value(t.workspace, '$.gid') as {{dbt.type_string()}}) as workspace_id,
            t.notes
        FROM
            {{ source('source_asana', 'projects') }} t
    )
    SELECT * FROM tmp

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.archived,
            t.created_at,
            t.current_status,
            t.due_date,
            t.modified_at,
            t.name,
            t.owner->>'gid' as owner_id,
            t.public,
            t.team->>'gid' as team_id,
            t.workspace->>'gid' as workspace_id,
            t.notes
        FROM
            {{ source('source_asana', 'projects') }} t
    )
    SELECT * FROM tmp

{%endif%}
