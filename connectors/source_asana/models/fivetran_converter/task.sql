{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.assignee:gid::STRING as assignee_id,
            t.completed,
            t.completed_at,
            t.completed_by:gid::STRING as completed_by_id,
            t.created_at,
            t.due_on,
            t.due_at,
            t.modified_at,
            t.name,
            t.parent:gid::STRING as parent_id,
            t.start_on,
            t.notes,
            t.liked,
            t.num_likes,
            t.workspace:gid::STRING as workspace_id
        FROM
            {{ source('source_asana', 'tasks') }} t
    )
    SELECT * FROM tmp;

{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            t.gid as as id,
            JSON_QUERY(t.assignee, '$.gid') as assignee_id,
            t.completed,
            t.completed_at,
            JSON_QUERY(t.completed_by, '$.gid') as completed_by_id,
            t.created_at,
            t.due_on,
            t.due_at,
            t.modified_at,
            t.name,
            JSON_QUERY(t.parent, '$.gid') as parent_id,
            t.start_on,
            t.notes,
            t.liked,
            t.num_likes,                    
            JSON_QUERY(t.workspace, '$.gid') as workspace_id
        FROM
            {{ source('source_asana', 'tasks') }} t
    )
    SELECT * FROM tmp;

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.assignee->>'gid' as assignee_id,
            t.completed,
            t.completed_at,
            t.completed_by->>'gid' as completed_by_id,
            t.created_at,
            t.due_on,
            t.due_at,
            t.modified_at,
            t.name,
            t.parent->>'gid' as parent_id,
            t.start_on,
            t.notes,
            t.liked,
            t.num_likes,
            t.workspace->>'gid' as workspace_id
        FROM
            {{ source('source_asana', 'tasks') }} t
    )
    SELECT * FROM tmp;

{%endif%}
