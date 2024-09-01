{% if target.type == "snowflake" %}

with base as (
    SELECT
        id as conversation_part_id,
        part_type,
        body,
        conversation_id,
        author:id as author_id,
        author:type as author_type,
        {{ dbt.date_trunc('second', 'created_at'::timestamp) }} as created_at,
        assigned_to:id as assigned_to_id,
        assigned_to:type as assigned_to_type,
        {{ dbt.date_trunc('second', 'conversation_updated_at'::timestamp) }} as conversation_updated_at,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at
    FROM
        {{source('source_intercom', 'conversation_parts')}},
        LATERAL FLATTEN(input => author)
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id as conversation_part_id,
        part_type,
        body,
        conversation_id,
        author:id as author_id,
        author:type as author_type,
        {{ dbt.date_trunc('second', 'created_at'::timestamp) }} as created_at,
        assigned_to:id as assigned_to_id,
        assigned_to:type as assigned_to_type,
        {{ dbt.date_trunc('second', 'conversation_updated_at'::timestamp) }} as conversation_updated_at,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at
    FROM
        {{source('source_intercom', 'conversation_parts')}},
        UNNEST(author) as author_element
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as conversation_part_id,
        part_type,
        body,
        conversation_id,
        author->>'id' as author_id,
        author->>'type' as author_type,
        to_timestamp(created_at) as created_at,
        assigned_to->>'id' as assigned_to_id,
        assigned_to->>'type' as assigned_to_type,
        to_timestamp(conversation_updated_at) as conversation_updated_at,
        to_timestamp(updated_at) as updated_at
    from {{source('source_intercom', 'conversation_parts')}}
)
select * from base

{% endif %}
