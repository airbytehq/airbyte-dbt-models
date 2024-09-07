
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            archived,
            description,
            id,
            name,
            overdue,
            projectId AS project_id,
            releaseDate AS release_date,
            released,
            startDate AS start_date
        FROM
            {{ source('source_jira', 'project_versions') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            archived,
            description,
            id,
            name,
            overdue,
            projectId AS project_id,
            releaseDate AS release_date,
            released,
            startDate AS start_date
        FROM
            {{ source('source_jira', 'project_versions') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            archived,
            description,
            id,
            name,
            overdue,
            projectId AS project_id,
            releaseDate AS release_date,
            released,
            startDate AS start_date
        FROM
            {{ source('source_jira', 'project_versions') }}
    )

    SELECT * FROM TMP

{%endif%}
