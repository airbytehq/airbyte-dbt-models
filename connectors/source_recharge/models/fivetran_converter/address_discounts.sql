{% if target.type == "snowflake" %}

with tmp as 
(
    select
        discount_id,
        id as address_id,
        NULL::integer as index  -- Snowflake requires explicit type casting

    FROM 
    {{ source('source_recharge', 'addresses') }}

)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as 
(
    select
        discount_id,
        id as address_id,
        NULL as index  -- BigQuery syntax for a NULL value, implicitly typed

    FROM 
    {{ source('source_recharge', 'addresses') }}

)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as 
(
    select
        discount_id,
        id as address_id,
        NULL::integer as index  -- PostgreSQL requires explicit type casting for NULL

    FROM 
    {{ source('source_recharge', 'addresses') }}

)

select *
from tmp

{% endif %}