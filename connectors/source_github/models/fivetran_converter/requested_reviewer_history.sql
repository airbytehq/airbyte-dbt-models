{% if target.type == "snowflake" %}

    with tmp as (
        SELECT
            pull_request_id,
            created_at,
            requested_id,
            removed
        FROM
            {{ source('source_github', 'requested_review_history') }}
        )
    select * from tmp

{% elif target.type == "bigquery" %}

        WITH tmp AS (
            SELECT
                pull_request_id,
                created_at,
                requested_id,
                removed
            FROM
            {{ source('source_github', 'requested_review_history') }}
        )
        SELECT * FROM tmp

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            pull_request_id,
            created_at,
            requested_id,
            removed
        FROM
            {{ source('source_github', 'requested_review_history') }}
    )
    SELECT * FROM tmp
{%endif%}