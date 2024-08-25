{% if target.type == "snowflake" %}

    with tmp as (
        SELECT
            issue_id,
            user_id
        FROM
            {{ source('source_github', 'issue_assignee') }}
        )
    select * from tmp

{% elif target.type == "bigquery" %}

        WITH tmp AS (
            SELECT
                issue_id,
                user_id
            FROM
            {{ source('source_github', 'issue_assignee') }}
        )
        SELECT * FROM tmp

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            issue_id,
            user_id        
        FROM
            {{ source('source_github', 'issue_assignee') }}
    )
    SELECT * FROM tmp

{%endif%}