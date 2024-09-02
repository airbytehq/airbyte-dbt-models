{% if target.type == "postgres" %}

    with tmp as (
        select
            cast(campaigns.id as {{ dbt.type_string() }}) as campaign_id,
            campaigns.name as campaign_name,
            campaigns.type as type,
            cast(campaigns."campaignGroup" as {{ dbt.type_string() }}) as campaign_group_id,
            campaigns.account as account_id,
            campaigns.status as status,
            campaigns."unitCost"->>'amount' as unit_cost_amount,
            campaigns."unitCost"->>'currencyCode' as unit_cost_currency_code,
            campaigns."dailyBudget"->>'amount' as daily_budget_amount,
            campaigns."dailyBudget"->>'currencyCode' as daily_budget_currency_code,
            campaigns."creativeSelection" as creative_selection,
            campaigns."costType" as cost_type,
            campaigns.format as format,
            campaigns."objectiveType" as objective_type,
            campaigns."optimizationTargetType" as optimization_target_type,
            campaigns."audienceExpansionEnabled" as is_audience_expansion_enabled,
            campaigns."offsiteDeliveryEnabled" as is_offsite_delivery_enabled,
            campaigns."runSchedule"->>'start' as run_schedule_start_at,
            campaigns."runSchedule"->>'end' as run_schedule_end_at,
            campaigns."lastModified" as last_modified_at,
            campaigns.created as created_at, -- Extracting the date portion only
            campaigns.version as version_tag,
            campaigns."locale"->>'country' as locale_country,
            campaigns."locale"->>'language' as locale_language,
            row_number() over (partition by campaigns.id order by campaigns."lastModified" desc) = 1 as is_latest_version,
            null as source_relation
        from
            {{ source('source_linkedin_ads', 'campaigns') }} as campaigns
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            campaigns.id as campaign_id,
            campaigns.name as campaign_name,
            campaigns.type as type,
            campaigns."campaignGroup" as campaign_group_id,
            campaigns.account as account_id,
            campaigns.status as status,
            JSON_EXTRACT_SCALAR(campaigns.dailyBudget, "$.amount") as daily_budget_amount,
            JSON_EXTRACT_SCALAR(campaigns.unitCost, "$.amount") as unit_cost_amount,
            campaigns."creativeSelection" as creative_selection,
            campaigns."costType" as cost_type,
            campaigns.format as format,
            campaigns."objectiveType" as objective_type,
            campaigns."optimizationTargetType" as optimization_target_type,
            campaigns."audienceExpansionEnabled" as is_audience_expansion_enabled,
            campaigns."offsiteDeliveryEnabled" as is_offsite_delivery_enabled,
            JSON_EXTRACT_SCALAR(campaigns.runSchedule, "$.start") as run_schedule_start_at,
            JSON_EXTRACT_SCALAR(campaigns.runSchedule, "$.end") as run_schedule_end_at,
            campaigns."lastModified" as last_modified_at,
            campaigns.created as created_at, -- Extracting the date portion only
            campaigns.version as version_tag,
            JSON_EXTRACT_SCALAR(campaigns.locale, "$.country") as locale_country,
            JSON_EXTRACT_SCALAR(campaigns.locale, "$.language") as locale_language
        from
            {{ source('source_linkedin_ads', 'campaigns') }} as campaigns
    )
    select * from tmp

{% elif target.type == "snowflake" %}

    with tmp as (
        select
            campaigns.id as campaign_id,
            campaigns.name as campaign_name,
            campaigns.type as type,
            campaigns."campaignGroup" as campaign_group_id,
            campaigns.account as account_id,
            campaigns.status as status,
            campaigns.dailyBudget::variant:"amount" as daily_budget_amount,
            campaigns.unitCost::variant:"amount" as unit_cost_amount,
            campaigns."creativeSelection" as creative_selection,
            campaigns."costType" as cost_type,
            campaigns.format as format,
            campaigns."objectiveType" as objective_type,
            campaigns."optimizationTargetType" as optimization_target_type,
            campaigns."audienceExpansionEnabled" as is_udience_expansion_enabled,
            campaigns."offsiteDeliveryEnabled" as is_offsite_delivery_enabled,
            campaigns.runSchedule::variant:"start" as run_schedule_start_at,
            campaigns.runSchedule::variant:"end" as run_schedule_end_at,
            campaigns."lastModified" as last_modified_at,
            campaigns.created as created_at,
            campaigns.version as version_tag,
            campaigns.locale::variant:"country" as locale_country,
            campaigns.locale::variant:"language" as locale_language
        from
            {{ source('source_linkedin_ads', 'campaigns') }} as campaigns
    )
    select * from tmp

{% endif %}
