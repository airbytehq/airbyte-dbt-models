with tmp as (
    SELECT
        cast(id as {{ dbt.type_string() }}) as issue_id,
        {{ fivetran_utils.json_extract('assignee', 'id') }} as user_id
    FROM
        {{ source('source_github', 'issues') }}
    )
select * from tmp