{% if target.type == "snowflake" %}

with base as (
    SELECT
        id as team_id,
        name
    FROM
    {{source('source_intercom', 'teams')}}
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id as team_id,
        name
    FROM
    {{source('source_intercom', 'teams')}}
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as team_id,
        name
    from {{source('source_intercom', 'teams')}}
)
select * from base

{% endif %}
