{% if target.type == "snowflake" %}

with tmp as
(
    select
        id as address_id,
        NULL::integer as index,  -- Snowflake: NULL explicitly cast to integer
        m.value:price::string as price,  -- Snowflake: Use colon notation to extract JSON keys
        m.value:code::string as code,    -- Also ensure the correct data type with casting
        m.value:title::string as title
    FROM
    {{ source('source_recharge', 'addresses') }},
    lateral flatten(input => ARRAY_CONSTRUCT(shipping_lines_override)) m  -- Snowflake: Use LATERAL FLATTEN to unnest JSON array

)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as
(
    select
        id as address_id,
        NULL as index,  -- BigQuery: NULL without explicit type casting
        JSON_VALUE(m, '$.price') as price,  -- BigQuery: Extract JSON values with JSON_VALUE
        JSON_VALUE(m, '$.code') as code,
        JSON_VALUE(m, '$.title') as title
    FROM
    {{ source('source_recharge', 'addresses') }},
    UNNEST (JSON_QUERY_ARRAY(shipping_lines_override)) m  -- BigQuery: Use UNNEST to expand JSON array

)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as
(
    select
        id as address_id,
        NULL::integer as index,  -- Postgres: NULL explicitly cast to integer
        m.value ->> 'price' as price,  -- Postgres: Use ->> operator to extract JSON key as text
        m.value ->> 'code' as code,
        m.value ->> 'title' as title
    FROM
    {{ source('source_recharge', 'addresses') }},
    jsonb_array_elements(shipping_lines_override::jsonb) as m(value)  -- Postgres: Use jsonb_array_elements to expand JSON array

)

select *
from tmp

{% endif %}
