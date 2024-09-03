with base as (
    select
        id,
        name,
        job_title
    from
    {{source('source_intercom', 'admins')}}
)
select * from base