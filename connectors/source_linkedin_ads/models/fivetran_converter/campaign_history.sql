{% if target.type == "postgres" %}

    with tmp as (
        select
            campaigns.id as campaign_id,
            campaigns.name as campaign_name,
            campaigns.type as type,
            campaigns."campaignGroup" as campaign_group_id,
            campaigns.account as account_id,
            campaigns.status as status,
            campaigns."dailyBudget"->>'amount' as daily_budget_amount,
            campaigns."unitCost"->>'amount' as unit_cost_amount,
            campaigns."creativeSelection" as creative_selection,
            campaigns."costType" as cost_type,
            campaigns.format as format,
            campaigns."objectiveType" as objective_type,
            campaigns."optimizationTargetType" as optimization_target_type,
            campaigns."audienceExpansionEnabled" as audience_expansion_enabled,
            campaigns."offsiteDeliveryEnabled" as offsite_delivery_enabled,
            campaigns."runSchedule"->>'start' as run_schedule_start,
            campaigns."runSchedule"->>'end' as run_schedule_end_at,
            campaigns."lastModified" as last_modified_time,
            campaigns.created::date as created_time, -- Extracting the date portion only
            campaigns.version as version_tag,
            campaigns."locale"->>'country' as locale_country,
            campaigns."locale"->>'language' as locale_language
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
            campaigns."audienceExpansionEnabled" as audience_expansion_enabled,
            campaigns."offsiteDeliveryEnabled" as offsite_delivery_enabled,
            JSON_EXTRACT_SCALAR(campaigns.runSchedule, "$.start") as run_schedule_start,
            JSON_EXTRACT_SCALAR(campaigns.runSchedule, "$.end") as run_schedule_end_at,
            campaigns."lastModified" as last_modified_time,
            DATE_TRUNC(campaigns.created, DAY) as created_time, -- Extracting the date portion only
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
            campaigns."audienceExpansionEnabled" as audience_expansion_enabled,
            campaigns."offsiteDeliveryEnabled" as offsite_delivery_enabled,
            campaigns.runSchedule::variant:"start" as run_schedule_start,
            campaigns.runSchedule::variant:"end" as run_schedule_end_at,
            campaigns."lastModified" as last_modified_time,
            DATE_TRUNC('DAY', campaigns.created) as created_time,
            campaigns.version as version_tag,
            campaigns.locale::variant:"country" as locale_country,
            campaigns.locale::variant:"language" as locale_language
        from
            {{ source('source_linkedin_ads', 'campaigns') }} as campaigns
    )
    select * from tmp

{% endif %}
