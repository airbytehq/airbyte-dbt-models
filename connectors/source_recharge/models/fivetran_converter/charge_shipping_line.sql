{% if target.type == "snowflake" %}

with tmp as
(
    select
        id as charge_id,
        NULL::integer as index,  -- Snowflake: Explicitly cast NULL to integer
        cast(m.value:price::string as {{ dbt.type_float() }})  as price,  -- Snowflake: Extract JSON keys using colon notation and cast to appropriate types
        m.value:code::string as code,
        m.value:title::string as title
    FROM
    {{ source('source_recharge', 'charges') }},
    lateral flatten(input => ARRAY_CONSTRUCT(shipping_lines)) m  -- Snowflake: Use LATERAL FLATTEN to unnest JSON array

)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as
(
    select
        id as charge_id,
        null as index,  -- BigQuery: NULL without explicit type casting
        cast(JSON_VALUE(m, '$.price') as {{ dbt.type_float() }}) as price,  -- BigQuery: Extract JSON values with JSON_VALUE
        JSON_VALUE(m, '$.code') as code,
        JSON_VALUE(m, '$.title') as title
    FROM
    {{ source('source_recharge', 'charges') }},
    UNNEST (JSON_QUERY_ARRAY(shipping_lines)) m  -- BigQuery: Use UNNEST to expand JSON array

)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as
(
    select
        id as charge_id,
        NULL::integer as index,  -- Postgres: Explicitly cast NULL to integer
        cast(m.value ->> 'price' as {{ dbt.type_float() }}) as price,  -- Postgres: Extract JSON key as text using ->>
        m.value ->> 'code' as code,
        m.value ->> 'title' as title
    FROM
    {{ source('source_recharge', 'charges') }},
    jsonb_array_elements(shipping_lines::jsonb) as m(value)  -- Postgres: Use jsonb_array_elements to unnest JSON array

)

select *
from tmp

{% endif %}
