
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            issueId AS issue_id,
            NULL AS related_issue_id,
            relationship
        FROM
            {{ source('source_jira', 'issue_remote_links') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            issueId AS issue_id,
            NULL AS related_issue_id,
            relationship
        FROM
            {{ source('source_jira', 'issue_remote_links') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            issueId AS issue_id,
            NULL AS related_issue_id,
            relationship
        FROM
            {{ source('source_jira', 'issue_remote_links') }}
    )

    SELECT * FROM TMP

{%endif%}
