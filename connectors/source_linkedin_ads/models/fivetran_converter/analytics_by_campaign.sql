{% if target.type == "postgres" %}

    with tmp as (
        select
            cast(ac.id as {{ dbt.type_string() }}) as campaign_id,
            aca.clicks as clicks,
            aca.impressions as impressions,
            aca."costInLocalCurrency" as cost_in_local_currency,
            aca."costInUsd" as cost,
            aca."conversionValueInLocalCurrency" as conversion_value_in_local_currency,
            aca.start_date::date as date_day,
            null as source_relation
        from
            {{ source('source_linkedin_ads', 'campaigns') }} as ac,
            {{ source('source_linkedin_ads', 'ad_campaign_analytics') }} as aca
    )
    select * from tmp

{% elif target.type == "snowflake" %}

    with tmp as (
        select
            ac.id as campaign_id,
            aca.clicks as clicks,
            aca.impressions as impressions,
            aca."costInLocalCurrency" as cost_in_local_currency,
            aca."costInUsd" as cost,
            aca."conversionValueInLocalCurrency" as conversion_value_in_local_currency,
            cast(aca.start_date as date) as date_day
        from
            {{ source('source_linkedin_ads', 'campaigns') }} as ac,
            {{ source('source_linkedin_ads', 'ad_campaign_analytics') }} as aca
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            ac.id as campaign_id,
            aca.clicks as clicks,
            aca.impressions as impressions,
            aca."costInLocalCurrency" as cost_in_local_currency,
            aca."costInUsd" as cost,
            aca."conversionValueInLocalCurrency" as conversion_value_in_local_currency,
            cast(aca.start_date as date) as date_day
        from
            {{ source('source_linkedin_ads', 'campaigns') }} as ac,
            {{ source('source_linkedin_ads', 'ad_campaign_analytics') }} as aca
    )
    select * from tmp

{% endif %}
