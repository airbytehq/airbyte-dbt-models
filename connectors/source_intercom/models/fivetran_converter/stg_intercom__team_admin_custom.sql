{% if target.type == "snowflake" %}

with base as (
    select
        jsonb_array_elements_text(admin_ids) as admin_id,
        name
    from
        {{ source('source_intercom', 'teams') }} t,
        jsonb_array_elements_text(t.admin_ids::jsonb) as admin_id_element
    where
        admin_id_element = t.name
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    select
        jsonb_array_elements_text(admin_ids) as admin_id,
        name
    from
        {{ source('source_intercom', 'teams') }} t,
        jsonb_array_elements_text(t.admin_ids::jsonb) as admin_id_element
    where
        admin_id_element = t.name
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        (admin_ids->>index) as admin_id,
        name
    from
        {{ source('source_intercom', 'teams') }} t,
        generate_series(0, jsonb_array_length(t.admin_ids::jsonb) - 1) as index
    where
        (t.admin_ids->>index) = t.name
)
select * from base

{% endif %}
