{% if target.type == "snowflake" %}

with base as (
    SELECT
        id AS team_id,
        value::string AS admin_id
    FROM
    {{source('source_intercom', 'teams')}},
    LATERAL FLATTEN(INPUT => admin_ids)
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id AS team_id,
        admin_id
    FROM
    {{source('source_intercom', 'teams')}},
    UNNEST(admin_ids) AS admin_id

)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as team_id,
        jsonb_array_elements_text(admin_ids) as admin_id
    from {{source('source_intercom', 'teams')}}
)
select * from base

{% endif %}
