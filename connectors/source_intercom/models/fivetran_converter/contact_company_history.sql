{% if target.type == "snowflake" %}

with base as (
    SELECT
        company_id,
        contact_id,
        {{ dbt.date_trunc('second', contact_updated_at::timestamp) }} as contact_updated_at
    FROM
    {{source('source_intercom', 'contact_company_history')}}
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        company_id,
        contact_id,
        TIMESTAMP_TRUNC(CAST(contact_updated_at AS timestamp), second) as contact_updated_at
    FROM
    {{source('source_intercom', 'contact_company_history')}}
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    SELECT
        company_id,
        contact_id,
        {{ dbt.date_trunc('second', contact_updated_at::timestamp) }} as contact_updated_at
    FROM
    {{source('source_intercom', 'contact_company_history')}}
)
select * from base

{% endif %}
