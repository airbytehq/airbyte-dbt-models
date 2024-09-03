with base as (
    select
        id,
        name,
        website,
        industry,
        to_timestamp(created_at) as created_at,
        to_timestamp(updated_at) as updated_at,
        user_count,
        session_count,
        monthly_spend,
        {{ fivetran_utils.json_extract('plan', 'id') }} as plan_id,
        {{ fivetran_utils.json_extract('plan', 'name') }} as plan_name
    from {{source('source_intercom', 'companies')}}
)
select * from base