WITH tmp AS (
    SELECT
        null as repository_id,
        null as team_id
    FROM
    {{ source('source_github', 'repo_teams') }}
)
SELECT * FROM tmp