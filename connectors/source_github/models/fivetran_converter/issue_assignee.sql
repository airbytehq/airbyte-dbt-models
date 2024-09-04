with tmp as (
    SELECT
        id as issue_id,
        {{ fivetran_utils.json_extract('assignee', 'id') }} as user_id
    FROM
        {{ source('source_github', 'issues') }}
    )
select * from tmp