{% if target.type == "snowflake" %}

with base as (
    select
        id as tag_id,
        trim(name) as name
    from
        {{ source('source_intercom', 'tags') }}
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    select
        id as tag_id,
        trim(name) as name
    from
        {{ source('source_intercom', 'tags') }}
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as tag_id,
        btrim(name) as name
    from
        {{ source('source_intercom', 'tags') }}
)
select * from base

{% endif %}
