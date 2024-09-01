{% if target.type == "snowflake" %}

with base as (
    SELECT
        id AS company_id,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as company_updated_at,
        array_agg((tags->>'id')::string) as tag_ids
    FROM
    {{source('source_intercom', 'companies')}}
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id AS company_id,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as company_updated_at,
        array_agg((tags->>'id')::string) as tag_ids
    FROM
    {{source('source_intercom', 'companies')}}
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as company_id,
        to_timestamp(updated_at) as company_updated_at,
        array_agg((tags->>'id')::text) as tag_ids
    from {{source('source_intercom', 'companies')}}
)
select * from base

{% endif %}
