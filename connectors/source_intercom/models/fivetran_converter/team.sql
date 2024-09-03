with base as (
    select
        id,
        name
    from {{source('source_intercom', 'teams')}}
)
select * from base