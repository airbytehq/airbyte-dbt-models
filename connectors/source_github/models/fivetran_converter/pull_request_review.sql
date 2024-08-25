{% if target.type == "snowflake" %}

    with tmp as (
        SELECT
            id as pull_request_review_id,
            pull_request_id,
            submitted_at,
            state,
            user_id
        FROM
            {{ source('source_github', 'pull_request_review') }}
        )
    select * from tmp

{% elif target.type == "bigquery" %}

        WITH tmp AS (
            SELECT
                id as pull_request_review_id,
                pull_request_id,
                submitted_at,
                state,
                user_id
            FROM
            {{ source('source_github', 'pull_request_review') }}
        )
        SELECT * FROM tmp

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id as pull_request_review_id,
            pull_request_id,
            submitted_at,
            state,
            user_id
        FROM
            {{ source('source_github', 'pull_request_review') }}
    )
    SELECT * FROM tmp
{%endif%}