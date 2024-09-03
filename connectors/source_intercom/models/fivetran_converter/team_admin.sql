with base as (
    select
        id as team_id,
        f.value as admin_id
    from {{source('source_intercom', 'teams')}}
    join lateral jsonb_array_elements_text(admin_ids) as f(value) on true
)
select * from base
