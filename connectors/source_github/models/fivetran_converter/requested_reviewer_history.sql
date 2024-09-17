WITH tmp AS (
    SELECT
        cast(id as {{ dbt.type_string() }}) as pull_request_id,
        created_at,
        null as requested_id,
        false as removed
    FROM
    {{ source('source_github', 'reviews') }}
)
SELECT * FROM tmp