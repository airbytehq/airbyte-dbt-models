{% if target.type == "snowflake" %}

with base as (
    SELECT
        contact_id::string,
        company_id::string,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at
    FROM
    {{source('source_intercom', 'contacts')}}
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        contact_id,
        company_id,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at
    FROM
    {{source('source_intercom', 'contacts')}}
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        contact_id,
        company_id,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at
    from {{source('source_intercom', 'contacts')}}
)
select * from base

{% endif %}
