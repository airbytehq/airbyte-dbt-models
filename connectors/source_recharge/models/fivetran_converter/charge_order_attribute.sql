{% if target.type == "snowflake" %}

with tmp as 
(
    select
        id as charge_id,
        NULL::integer as index,  -- Snowflake: Explicitly cast NULL to integer
        order_attributes::string as order_attribute  -- Snowflake: Cast order_attributes to string if needed
    FROM 
    {{ source('source_recharge', 'charges') }}

)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as 
(
    select
        id as charge_id,
        null as index,  -- BigQuery: NULL without explicit type casting
        order_attributes as order_attribute  -- BigQuery: Leave order_attributes unchanged
    FROM 
    {{ source('source_recharge', 'charges') }}

)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as 
(
    select
        id as charge_id,
        NULL::integer as index,  -- Postgres: Explicitly cast NULL to integer
        order_attributes::text as order_attribute  -- Postgres: Cast order_attributes to text if needed
    FROM 
    {{ source('source_recharge', 'charges') }}

)

select *
from tmp

{% endif %}
