{% if target.type == "snowflake" %}

    with tmp as (
        SELECT
            issue_id,
            merged_at
        FROM
            {{ source('source_github', 'issue_merged') }}
        )
    select * from tmp

{% elif target.type == "bigquery" %}

        WITH tmp AS (
            SELECT
                issue_id,
                merged_at
            FROM
            {{ source('source_github', 'issue_merged') }}
        )
        SELECT * FROM tmp

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            issue_id,
            merged_at
        FROM
            {{ source('source_github', 'issue_closed_hsitory') }}
    )
    SELECT * FROM tmp

{%endif%}