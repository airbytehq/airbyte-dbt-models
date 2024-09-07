
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            id,
            description,
            name,
            statusCategory->>'id' AS status_category_id
        FROM
            {{ source('source_jira', 'workflow_statuses') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            id,
            description,
            name,
            JSON_VALUE(statusCategory, '$.id') AS status_category_id
        FROM
            {{ source('source_jira', 'workflow_statuses') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            id,
            description,
            name,
            statusCategory:"id"::string AS status_category_id
        FROM
            {{ source('source_jira', 'workflow_statuses') }}
    )

    SELECT * FROM TMP

{%endif%}
