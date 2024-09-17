
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            emailAddress AS email,
            accountId AS id,
            locale,
            name,
            timeZone AS time_zone,
            displayName AS username
        FROM
            {{ source('source_jira', 'users') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            emailAddress AS email,
            accountId AS id,
            locale,
            name,
            timeZone AS time_zone,
            displayName AS username
        FROM
            {{ source('source_jira', 'users') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            emailAddress AS email,
            accountId AS id,
            locale,
            name,
            timeZone AS time_zone,
            displayName AS username
        FROM
            {{ source('source_jira', 'users') }}
    )

    SELECT * FROM TMP

{%endif%}
