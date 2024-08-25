{% if target.type == "snowflake" %}

    with tmp as (
        SELECT
            repository_id,
            team_id
        FROM
            {{ source('source_github', 'repo_team') }}
        )
    select * from tmp

{% elif target.type == "bigquery" %}

        WITH tmp AS (
            SELECT
                repository_id,
                team_id
            FROM
            {{ source('source_github', 'repo_team') }}
        )
        SELECT * FROM tmp

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            repository_id,
            team_id
        FROM
            {{ source('source_github', 'repo_team') }}
    )
    SELECT * FROM tmp
{%endif%}