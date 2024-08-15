{% if target.type == "snowflake" %}

    with tmp as (
        select
            creatives.id as creative_id,
            creatives."campaign" as campaign_id,
            creatives."intendedStatus" as status,
            {{ dbt.date_trunc('second', 'timestamp with time zone', 'to_timestamp(creatives."lastModifiedAt")') }} as last_modified_at,
            {{ dbt.date_trunc('second', 'timestamp with time zone', 'to_timestamp(creatives."createdAt")') }} as created_at
        from
            {{ source('source_linkedin_ads', 'creatives') }} as creatives
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            creatives.id as creative_id,
            creatives."campaign" as campaign_id,
            creatives."intendedStatus" as status,
            {{ dbt.date_trunc('second', 'timestamp with time zone', 'timestamp_seconds(creatives."lastModifiedAt")') }} as last_modified_at,
            {{ dbt.date_trunc('second', 'timestamp with time zone', 'timestamp_seconds(creatives."createdAt")') }} as created_at
        from
            {{ source('source_linkedin_ads', 'creatives') }} as creatives
    )
    select * from tmp

{% elif target.type == "postgres" %}

    with tmp as (
        select
            creatives.id as creative_id,
            creatives."campaign" as campaign_id,
            creatives."intendedStatus" as status,
            {{ dbt.date_trunc('second', 'to_timestamp(creatives."lastModifiedAt")::timestamp') }} as last_modified_at,
            {{ dbt.date_trunc('second', 'to_timestamp(creatives."createdAt")::timestamp') }} as created_at
        from
            {{ source('source_linkedin_ads', 'creatives') }} as creatives
    )
    select * from tmp

{% endif %}
