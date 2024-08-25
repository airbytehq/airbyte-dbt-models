{% if target.type == "snowflake" %}

    with tmp as (
        SELECT
            issue_id,
            updated_at,
            is_closed
        FROM
            {{ source('source_github', 'issue_closed_history') }}
        )
    select * from tmp

{% elif target.type == "bigquery" %}

        WITH tmp AS (
            SELECT
                issue_id,
                updated_at,
                is_closed
            FROM
            {{ source('source_github', 'issue_closed_history') }}
        )
        SELECT * FROM tmp

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            issue_id,
            updated_at,
            is_closed   
        FROM
            {{ source('source_github', 'issue_closed_hsitory') }}
    )
    SELECT * FROM tmp

{%endif%}