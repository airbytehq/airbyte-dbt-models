{% if target.type == "snowflake" %}

with base as (
    SELECT
        id as conversation_id,
        value::string as tag_id
    FROM
    {{source('source_intercom', 'conversations')}},
    LATERAL FLATTEN(INPUT => tags)
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id as conversation_id,
        tag_id
    FROM
    {{source('source_intercom', 'conversations')}},
    UNNEST(tags) AS tag_id
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as conversation_id,
        jsonb_array_elements_text(tags) as tag_id
    from {{source('source_intercom', 'conversations')}}
)
select * from base

{% endif %}
