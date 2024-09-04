WITH tmp AS (
    SELECT
        id,
        created_at,
        null as requested_id,
        null as removed
    FROM
    {{ source('source_github', 'reviews') }}
)
SELECT * FROM tmp