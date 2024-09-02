{% if target.type == "postgres" %}

    with tmp as (
        select
            cast(cg.id as {{ dbt.type_string() }}) as campaign_group_id,
            cg.name as campaign_group_name,
            cast(cg.account as {{dbt.type_string()}}) account_id,
            cg.status as status,
            cg.backfilled as is_backfilled,
            cg."runSchedule"->>'start' as run_schedule_start_at,
            cg."runSchedule"->>'end' as run_schedule_end_at,
            cg."lastModified" as last_modified_at,
            cg.created::date as created_at,
            row_number() over (partition by cg.id order by cg."lastModified" desc) = 1 as is_latest_version,
            null as source_relation
        from
            {{ source('source_linkedin_ads', 'campaign_groups') }} as cg
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            cg.id as campaign_group_id,
            cg.name as name,
            cg.account as account_id,
            cg.status as status,
            cg.backfilled as is_backfilled,
            JSON_EXTRACT_SCALAR(cg.runSchedule, "$.start") as run_schedule_start,
            JSON_EXTRACT_SCALAR(cg.runSchedule, "$.end") as run_schedule_end,
            cg."lastModified" as last_modified_at,
            DATE_TRUNC(cg.created, DAY) as created_at
        from
            {{ source('source_linkedin_ads', 'campaign_groups') }} as cg
    )
    select * from tmp

{% elif target.type == "snowflake" %}

    with tmp as (
        select
            cg.id as campaign_group_id,
            cg.name as name,
            cg.account as account_id,
            cg.status as status,
            cg.backfilled as is_backfilled,
            cg.runSchedule:start::variant as run_schedule_start,
            cg.runSchedule:end::variant as run_schedule_end,
            cg."lastModified" as last_modified_at,
            DATE_TRUNC('DAY', cg.created) as created_at
        from
            {{ source('source_linkedin_ads', 'campaign_groups') }} as cg
    )
    select * from tmp

{% endif %}
