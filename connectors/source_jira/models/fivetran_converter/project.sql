
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            description,
            id,
            key,
            lead->>'accountId' AS lead_id,
            name,
            projectCategory->>'id' AS project_category_id,
            NULL AS permission_scheme_id
        FROM
            {{ source('source_jira', 'projects') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            description,
            id,
            key,
            JSON_VALUE(lead, '$.accountId') AS lead_id,
            name,
            JSON_VALUE(projectCategory, '$.id') AS project_category_id,
            NULL AS permission_scheme_id
        FROM
            {{ source('source_jira', 'projects') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            description,
            id,
            key,
            lead:"accountId"::string AS lead_id,
            name,
            projectCategory:"id"::string AS project_category_id,
            NULL AS permission_scheme_id
        FROM
            {{ source('source_jira', 'projects') }}
    )

    SELECT * FROM TMP

{%endif%}
