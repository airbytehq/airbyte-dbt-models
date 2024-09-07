
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            id AS field_id,
            NULL AS issue_id,
            NULL AS time,
            name AS value
        FROM
            {{ source('source_jira', 'issue_fields') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            id AS field_id,
            NULL AS issue_id,
            NULL AS time,
            name AS value
        FROM
            {{ source('source_jira', 'issue_fields') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            id AS field_id,
            NULL AS issue_id,
            NULL AS time,
            name AS value
        FROM
            {{ source('source_jira', 'issue_fields') }}
    )

    SELECT * FROM TMP

{%endif%}
