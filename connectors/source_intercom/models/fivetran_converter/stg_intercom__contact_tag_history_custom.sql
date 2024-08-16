{% if target.type == "snowflake" %}

    with tmp as (
        select
            id as contact_id,
            timestamp_ntz(updated_at) as contact_updated_at,  -- Convert to Snowflake timestamp
            -- Assuming tags is an array of objects and we need to extract tag IDs
            array_agg(tag.value:id::string) as tag_id   -- Flattening array of tag IDs
        from
            {{ source('source_intercom', 'contacts') }},
            lateral flatten(input => tags) as tag  -- Flatten the nested array of tags
        group by
            id, updated_at
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            id as contact_id,
            timestamp_seconds(updated_at) as contact_updated_at,  -- Convert to BigQuery timestamp
            array_agg(tag.id) as tag_id  -- Aggregating array of tag IDs
        from
            {{ source('source_intercom', 'contacts') }},
            unnest(tags) as tag  -- Unnest the array of tags
        group by
            id, updated_at
    )
    select * from tmp

{% elif target.type == "postgres" %}

    with tmp as (
        select
            id as contact_id,
            to_timestamp(updated_at) as contact_updated_at,  -- Convert to PostgreSQL timestamp
            array_agg((tag->>'id')::integer) as tag_id  -- Aggregating array of tag IDs
        from
            {{ source('source_intercom', 'contacts') }},
            jsonb_array_elements(tags) as tag  -- Unnest the JSON array of tags
        group by
            id, updated_at
    )
    select * from tmp

{% endif %}
