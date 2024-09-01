{% if target.type == "snowflake" %}

with base as (
    SELECT
        id as contact_id,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as contact_updated_at,
        array_agg((tag->>'id')::integer) as tag_id  -- Aggregating array of tag IDs
    FROM
        {{source('source_intercom', 'contacts')}},
        LATERAL FLATTEN(input => tags)
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id as contact_id,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as contact_updated_at,
        array_agg((tag->>'id')::integer) as tag_id  -- Aggregating array of tag IDs
    FROM
        {{source('source_intercom', 'contacts')}},
        UNNEST(tags) as tag
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as contact_id,
        to_timestamp(updated_at) as contact_updated_at,
        array_agg((tag->>'id')::integer) as tag_id  -- Aggregating array of tag IDs
    from {{source('source_intercom', 'contacts')}}
    join lateral jsonb_array_elements(tags) as tag on true
)
select * from base

{% endif %}
