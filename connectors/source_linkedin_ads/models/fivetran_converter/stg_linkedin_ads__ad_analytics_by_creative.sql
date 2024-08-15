{% if target.type == "postgres" %}

    with tmp as (
        select
            cr.id as creative_id,
            aca.clicks as clicks,
            aca.impressions as impressions,
            "aca"."costInLocalCurrency" as cost_in_local_currency,
            "aca"."costInUsd" as cost_in_usd,
            "aca"."conversionValueInLocalCurrency" as conversion_value_in_local_currency,
            {{ dbt.date_trunc('day', 'aca.start_date') }} as date_day
        from
            {{ source('source_linkedin_ads', 'creatives') }} as cr,
            {{ source('source_linkedin_ads', 'ad_creative_analytics') }} as aca
    )
    select * from tmp

{% elif target.type == "snowflake" %}

    with tmp as (
        select
            cr.id as creative_id,
            aca.clicks as clicks,
            aca.impressions as impressions,
            aca.costInLocalCurrency as cost_in_local_currency,
            aca.costInUsd as cost_in_usd,
            aca.conversionValueInLocalCurrency as conversion_value_in_local_currency,
            {{ dbt.date_trunc('day', 'aca.start_date') }} as date_day
        from
            {{ source('source_linkedin_ads', 'creatives') }} as cr,
            {{ source('source_linkedin_ads', 'ad_creative_analytics') }} as aca
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            cr.id as creative_id,
            aca.clicks as clicks,
            aca.impressions as impressions,
            aca.costInLocalCurrency as cost_in_local_currency,
            aca.costInUsd as cost_in_usd,
            aca.conversionValueInLocalCurrency as conversion_value_in_local_currency,
            {{ dbt.date_trunc('day', 'aca.start_date') }} as date_day
        from
            {{ source('source_linkedin_ads', 'creatives') }} as cr,
            {{ source('source_linkedin_ads', 'ad_creative_analytics') }} as aca
    )
    select * from tmp

{% endif %}
