{% if target.type == "snowflake" %}

with base as (
    SELECT
        id AS company_id,
        name,
        website,
        industry,
        {{ dbt.date_trunc('second', 'created_at'::timestamp) }} as created_at,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at,
        user_count,
        session_count,
        monthly_spend,
        plan.id as plan_id,
        plan.name as plan_name
    FROM
    {{source('source_intercom', 'companies')}}
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id AS company_id,
        name,
        website,
        industry,
        {{ dbt.date_trunc('second', 'created_at'::timestamp) }} as created_at,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at,
        user_count,
        session_count,
        monthly_spend,
        plan.id as plan_id,
        plan.name as plan_name
    FROM
    {{source('source_intercom', 'companies')}}
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as company_id,
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
    from {{source('source_intercom', 'companies')}}
)
select * from base

{% endif %}
