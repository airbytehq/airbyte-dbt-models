with tmp as (
    SELECT
        id as issue_id,
        updated_at,
        case when closed_at is not null then true else false end as closed
    FROM
        {{ source('source_github', 'issues') }}
    )
select * from tmp