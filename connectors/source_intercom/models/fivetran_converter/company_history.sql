{% if target.type == "snowflake" %}

    with tmp as (
        select
            coalesce(id, company_id) as company_id,
            name,
            website,
            industry,
            timestamp_ntz(created_at) as created_at,
            timestamp_ntz(updated_at) as updated_at,
            user_count,
            session_count,
            monthly_spend,
            plan:id::string as plan_id,
            plan:name::string as plan_name
        from
            {{ source('source_intercom', 'companies') }}
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            coalesce(id, company_id) as company_id,
            name,
            website,
            industry,
            timestamp_seconds(created_at) as created_at,
            timestamp_seconds(updated_at) as updated_at,
            user_count,
            session_count,
            monthly_spend,
            plan.id as plan_id,
            plan.name as plan_name
        from
            {{ source('source_intercom', 'companies') }}
    )
    select * from tmp

{% elif target.type == "postgres" %}

    with tmp as (
        select
            coalesce(id, company_id) as company_id,
            name,
            website,
            industry,
            to_timestamp(created_at) as created_at,
            to_timestamp(updated_at) as updated_at,
            user_count,
            session_count,
            monthly_spend,
            plan->>'id' as plan_id,
            plan->>'name' as plan_name
        from
            {{ source('source_intercom', 'companies') }}
    )
    select * from tmp

{% endif %}
