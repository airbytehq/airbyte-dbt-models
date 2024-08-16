{% if target.type == "snowflake" %}

    with tmp as (
        select
            id as company_id,
            timestamp_ntz(updated_at) as company_updated_at,
            tags[0]:id::string as tag_id
        from
            {{ source('source_intercom', 'companies') }}
        lateral flatten(input => tags) as tags
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            id as company_id,
            timestamp_seconds(updated_at) as company_updated_at,
            tags.id as tag_id
        from
            {{ source('source_intercom', 'companies') }},
            unnest(tags) as tags
    )
    select * from tmp

{% elif target.type == "postgres" %}

    with tmp as (
        select
            id as company_id,
            to_timestamp(updated_at) as company_updated_at,  -- Convert to PostgreSQL timestamp
            -- Extract the first tag ID from the tags array
            (tags->0->>'id') as tag_id  -- Verify if this extracts the correct tag ID
        from
            {{ source('source_intercom', 'companies') }}
        -- Unnest the tags array to produce one row per tag
        cross join lateral jsonb_array_elements(tags) as tags  -- Unnest the tags array to produce one row per tag
    )
    select * from tmp

{% endif %}
