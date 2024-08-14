{% if target.type == "snowflake" %}

    {% set schema = var('airbyte_schema', target.schema) %}
    {% set table_ad_campaign_analytics = schema ~ '.ad_campaign_analytics' %}
    {% set table_campaigns = schema ~ '.campaigns' %}

    with tmp as (
        select
            ac.id as campaign_id,
            aca.clicks as clicks,
            aca.impressions as impressions,
            aca.costInLocalCurrency as cost_in_local_currency,
            aca.costInUsd as cost_in_usd,
            aca.conversionValueInLocalCurrency as conversion_value_in_local_currency,
            {{ dbt.date_trunc('day', 'aca.start_date') }} as date_day
        from
            {{ table_ad_campaign_analytics }} aca
        join
            {{ table_campaigns }} ac
        on
            aca.campaign_id = ac.id
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    {% set schema = var('airbyte_schema', target.schema) %}
    {% set table_ad_campaign_analytics = schema ~ '.ad_campaign_analytics' %}
    {% set table_campaigns = schema ~ '.campaigns' %}

    with tmp as (
        select
            ac.id as campaign_id,
            aca.clicks as clicks,
            aca.impressions as impressions,
            aca.costInLocalCurrency as cost_in_local_currency,
            aca.costInUsd as cost_in_usd,
            aca.conversionValueInLocalCurrency as conversion_value_in_local_currency,
            {{ dbt.date_trunc('day', 'aca.start_date') }} as date_day
        from
            {{ table_ad_campaign_analytics }} aca
        join
            {{ table_campaigns }} ac
        on
            aca.campaign_id = ac.id
    )
    select * from tmp

{% elif target.type == "postgres" %}

    {% set schema = var('airbyte_schema', target.schema) %}
    {% set table_ad_campaign_analytics = schema ~ '.ad_campaign_analytics' %}
    {% set table_campaigns = schema ~ '.campaigns' %}

    with tmp as (
        select
            ac.id as campaign_id,
            aca.clicks as clicks,
            aca.impressions as impressions,
            aca.costInLocalCurrency as cost_in_local_currency,
            aca.costInUsd as cost_in_usd,
            aca.conversionValueInLocalCurrency as conversion_value_in_local_currency,
            {{ dbt.date_trunc('day', 'aca.start_date') }} as date_day
        from
            {{ table_ad_campaign_analytics }} aca
        join
            {{ table_campaigns }} ac
        on
            aca.campaign_id = ac.id
    )
    select * from tmp

{% endif %}
