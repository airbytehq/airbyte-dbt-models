
{% if target.type == "postgres" %}

    WITH TMP1 AS (
        SELECT
            id,
            (schema->>'type' = 'array') AS is_array,
            custom AS is_custom,
            name
        FROM
            {{ source('source_jira', 'issue_fields') }}
    ),

    TMP2 AS (
        SELECT
            *
        FROM
            TMP1
        WHERE
            is_array
    )

    SELECT * FROM TMP2

{% elif target.type == "bigquery" %}

    WITH TMP1 AS (
        SELECT
            id,
            (JSON_VALUE(schema, '$.type') = 'array') AS is_array,
            custom AS is_custom,
            name
        FROM
            {{ source('source_jira', 'issue_fields') }}
    ),

    TMP2 AS (
        SELECT
            *
        FROM
            TMP1
        WHERE
            is_array
    )

    SELECT * FROM TMP2

{% elif target.type == "snowflake" %}

    WITH TMP1 AS (
        SELECT
            id,
            (schema:"type"::string = 'array') AS is_array,
            custom AS is_custom,
            name
        FROM
            {{ source('source_jira', 'issue_fields') }}
    ),

    TMP2 AS (
        SELECT
            *
        FROM
            TMP1
        WHERE
            is_array
    )

    SELECT * FROM TMP2

{%endif%}
