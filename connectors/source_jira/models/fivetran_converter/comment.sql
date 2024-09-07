
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            author AS author_id,
            body,
            created,
            id,
            issueId AS issue_id,
            jsdPublic AS is_public,
            updateAuthor AS update_author_id,
            updated
        FROM
            {{ source('source_jira', 'issue_comments') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            author AS author_id,
            body,
            created,
            id,
            issueId AS issue_id,
            jsdPublic AS is_public,
            updateAuthor AS update_author_id,
            updated
        FROM
            {{ source('source_jira', 'issue_comments') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            author AS author_id,
            body,
            created,
            id,
            issueId AS issue_id,
            jsdPublic AS is_public,
            updateAuthor AS update_author_id,
            updated
        FROM
            {{ source('source_jira', 'issue_comments') }}
    )

    SELECT * FROM TMP

{%endif%}
