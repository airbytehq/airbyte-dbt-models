{% if target.type == "snowflake" %}

with base as (
    select
        id as conversation_part_id,
        part_type,
        body,
        conversation_id,
        (author->>'id')::string as author_id,
        (author->>'type')::string as author_type,
        {{ dbt.date_trunc('second', created_at) }} as created_at,
        assigned_to->>'id' as assigned_to_id,
        assigned_to->>'type' as assigned_to_type,
        {{ dbt.date_trunc('second', conversation_updated_at) }} as conversation_updated_at,
        {{ dbt.date_trunc('second', updated_at) }} as updated_at
    from
        {{ source('source_intercom', 'conversation_parts') }}
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    select
        id as conversation_part_id,
        part_type,
        body,
        conversation_id,
        JSON_EXTRACT_SCALAR(author, '$.id') as author_id,
        JSON_EXTRACT_SCALAR(author, '$.type') as author_type,
        timestamp_seconds(created_at) as created_at,
        JSON_EXTRACT_SCALAR(assigned_to, '$.id') as assigned_to_id,
        JSON_EXTRACT_SCALAR(assigned_to, '$.type') as assigned_to_type,
        timestamp_seconds(conversation_updated_at) as conversation_updated_at,
        timestamp_seconds(updated_at) as updated_at
    from
        {{ source('source_intercom', 'conversation_parts') }}
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as conversation_part_id,
        part_type,
        body,
        conversation_id,
        (author->>'id')::varchar as author_id,
        (author->>'type')::varchar as author_type,
        to_timestamp(created_at::bigint) as created_at,
        assigned_to->>'id' as assigned_to_id,
        assigned_to->>'type' as assigned_to_type,
        to_timestamp(conversation_updated_at::bigint) as conversation_updated_at,
        to_timestamp(updated_at::bigint) as updated_at
    from
        {{ source('source_intercom', 'conversation_parts') }}
)
select * from base

{% endif %}
