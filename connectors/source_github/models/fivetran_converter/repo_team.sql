WITH tmp AS (
    SELECT
        null as repository_id,
        null as team_id
    FROM
    {{ source('source_github', 'teams') }}
)
SELECT * FROM tmp