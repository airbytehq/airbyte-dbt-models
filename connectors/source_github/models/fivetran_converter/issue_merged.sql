    WITH tmp AS (
        SELECT
            id as issue_id,
            {{ fivetran_utils.json_extract('pull_request', 'merged_at') }} as merged_at
        FROM
            {{ source('source_github', 'issues') }}
    )
    SELECT * FROM tmp