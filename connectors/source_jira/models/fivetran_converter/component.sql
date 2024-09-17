
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            description,
            id,
            name,
            projectId AS project_id
        FROM
            {{ source('source_jira', 'issue_comments') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            description,
            id,
            name,
            projectId AS project_id
        FROM
            {{ source('source_jira', 'issue_comments') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            description,
            id,
            name,
            projectId AS project_id
        FROM
            {{ source('source_jira', 'issue_comments') }}
    )

    SELECT * FROM TMP

{%endif%}
