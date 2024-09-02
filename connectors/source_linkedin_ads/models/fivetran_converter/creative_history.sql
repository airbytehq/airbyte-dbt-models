{% if target.type == "snowflake" %}

    with tmp as (
        select
            creatives.id as creative_id,
            creatives.campaign as campaign_id,
            creatives."intendedStatus" as status,
            to_timestamp_ntz(creatives."lastModifiedAt" / 1000) as last_modified_at, -- Convert from milliseconds to timestamp
            to_timestamp_ntz(creatives."createdAt" / 1000) as created_at -- Convert from milliseconds to timestamp
        from
            {{ source('source_linkedin_ads', 'creatives') }} as creatives
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            creatives.id as creative_id,
            creatives.campaign as campaign_id,
            creatives."intendedStatus" as status,
            timestamp_micros(creatives."lastModifiedAt") as last_modified_at, -- Convert from microseconds to timestamp
            timestamp_micros(creatives."createdAt") as created_at -- Convert from microseconds to timestamp
        from
            {{ source('source_linkedin_ads', 'creatives') }} as creatives
    )
    select * from tmp

{% elif target.type == "postgres" %}

    with tmp as (
        select
            cast(creatives.id as {{ dbt.type_string() }}) as creative_id,
            creatives.campaign as campaign_id,
            creatives."intendedStatus" as status,
            null as click_uri,
            null as base_url,
            null as url_host,
            null as url_path,
            null as utm_source,
            null as utm_medium,
            null as utm_campaign,
            null as utm_content,
            null as utm_term,
            to_timestamp(creatives."lastModifiedAt" / 1000) as last_modified_at, -- Convert from milliseconds to timestamp
            to_timestamp(creatives."createdAt" / 1000) as created_at, -- Convert from milliseconds to timestamp
            row_number() over (partition by creatives.id order by creatives."lastModifiedAt" desc) = 1 as is_latest_version,
            null as source_relation
        from
            {{ source('source_linkedin_ads', 'creatives') }} as creatives
    )
    select * from tmp

{% endif %}
