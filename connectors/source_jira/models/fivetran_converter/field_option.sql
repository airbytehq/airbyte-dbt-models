
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            id,
            fieldId AS parent_id,
            value AS name
        FROM
            {{ source('source_jira', 'issue_custom_field_options') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            id,
            fieldId AS parent_id,
            value AS name
        FROM
            {{ source('source_jira', 'issue_custom_field_options') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            id,
            fieldId AS parent_id,
            value AS name
        FROM
            {{ source('source_jira', 'issue_custom_field_options') }}
    )

    SELECT * FROM TMP

{%endif%}
