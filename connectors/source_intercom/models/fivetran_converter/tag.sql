with base as (
    select
        id,
        name
    from {{source('source_intercom', 'tags')}}
)
select * from base