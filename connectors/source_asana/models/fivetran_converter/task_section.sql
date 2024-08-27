{% if target.type == "snowflake" %}
    WITH tmp AS (
        SELECT
            t.gid AS task_id,
            m.value:project:gid::STRING AS project_id,
            m.value:section:gid::STRING AS section_id
        FROM
            {{ source('source_asana', 'tasks') }} t,
            LATERAL FLATTEN(input => PARSE_JSON(t.memberships)) m
    )
    SELECT section_id, project_id
    FROM tmp
    WHERE project_id IS NOT NULL


{% elif target.type == "bigquery" %}
    WITH tmp AS (
        SELECT
            t.gid as task_id,
            JSON_EXTRACT_SCALAR(JSON_EXTRACT(m, '$.project'), '$.gid') AS project_id,
            JSON_EXTRACT_SCALAR(JSON_EXTRACT(m, '$.section'), '$.gid') AS section_id,
        FROM
            {{ source('source_asana', 'tasks') }} t,
            UNNEST(JSON_EXTRACT_ARRAY(t.memberships)) AS m
    )
    SELECT section_id, project_id
    FROM tmp
    WHERE project_id IS NOT NULL

{% elif target.type == "postgres" %}
    WITH tmp AS (
        SELECT
            t.gid AS task_id,
            jsonb_extract_path_text(m.value::jsonb, 'project', 'gid') AS project_id,
            jsonb_extract_path_text(m.value::jsonb, 'section', 'gid') AS section_id
        FROM
            {{ source('source_asana', 'tasks') }} t,
            LATERAL jsonb_array_elements(t.memberships::jsonb) AS m(value)
    )
    SELECT section_id, project_id
    FROM tmp
    WHERE project_id IS NOT NULL

{%endif%}
