{% if target.type == "snowflake" %}

with base as (
    SELECT
        id AS admin_id,
        name,
        job_title
    FROM
    {{source('source_intercom', 'admins')}}
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id AS admin_id,
        name,
        job_title
    FROM
    {{source('source_intercom', 'admins')}}
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as admin_id,
        name,
        job_title
    from {{source('source_intercom', 'admins')}}
)
select * from base

{% endif %}
