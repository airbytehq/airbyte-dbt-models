with base as (
    select
        id,
        part_type,
        body,
        conversation_id,
        to_timestamp(created_at) as created_at,
        to_timestamp(conversation_updated_at) as conversation_updated_at,
        to_timestamp(updated_at) as updated_at,
        {{ fivetran_utils.json_extract('author', 'id') }} as author_id,
        {{ fivetran_utils.json_extract('author', 'type') }} as author_type,
        {{ fivetran_utils.json_extract('assigned_to', 'id') }} as assigned_to_id,
        {{ fivetran_utils.json_extract('assigned_to', 'type') }} as assigned_to_type
    from {{source('source_intercom', 'conversation_parts')}}
)
select * from base

