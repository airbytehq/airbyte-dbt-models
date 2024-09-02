{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.assignee:gid::STRING as assignee_id,
            t.completed,
            t.completed_at,
            t.completed_by:gid::STRING as completed_by_id,
            t.created_at,
            cast(t.due_on as {{ dbt.type_timestamp() }}) as due_on,
            cast(t.due_at as {{ dbt.type_timestamp() }}) as due_at,
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
    SELECT * FROM tmp

{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            cast(json_value(t.assignee, '$.gid') as {{ dbt.type_string() }}) as assignee_id,
            t.completed,
            t.completed_at,
            cast(json_value(t.completed_by, '$.gid') as {{ dbt.type_string() }}) as completed_by_id,
            t.created_at,
            cast(t.due_on as {{ dbt.type_timestamp() }}) as due_on,
            cast(t.due_at as {{ dbt.type_timestamp() }}) as due_at,
            t.modified_at,
            t.name,
            cast(json_value(t.parent, '$.gid') as {{ dbt.type_string() }}) as parent_id,
            t.start_on,
            t.notes,
            t.liked,
            t.num_likes,
            cast(json_value(t.workspace, '$.gid') as {{ dbt.type_string() }}) as workspace_id
        FROM
            {{ source('source_asana', 'tasks') }} t
    )
    SELECT * FROM tmp

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            t.gid as id,
            t.assignee->>'gid' as assignee_id,
            t.completed,
            t.completed_at,
            t.completed_by->>'gid' as completed_by_id,
            t.created_at,
            cast(t.due_on as {{ dbt.type_timestamp() }}) as due_on,
            cast(t.due_at as {{ dbt.type_timestamp() }}) as due_at,
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
    SELECT * FROM tmp

{%endif%}
