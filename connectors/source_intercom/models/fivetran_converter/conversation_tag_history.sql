{% if target.type == "snowflake" %}

with base as (
    select
        id as conversation_id,
        array_agg((tag->>'id')::string) as tag_ids
    from
        {{ source('source_intercom', 'conversations') }},
        lateral flatten(input => tags) tag
    group by
        id
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    select
        id as conversation_id,
        array_agg(JSON_EXTRACT_SCALAR(tag, '$.id')) as tag_ids
    from
        {{ source('source_intercom', 'conversations') }},
        unnest(tags) as tag
    group by
        id
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as conversation_id,
        array_agg((tag->>'id')::varchar) as tag_ids  -- Extracting tag IDs from the nested object
    from
        {{ source('source_intercom', 'conversations') }},
        jsonb_array_elements(tags) as tag  -- Flatten the tags array into individual records
    group by
        id
)
select * from base

{% endif %}
