{% if target.type == "snowflake" %}

with tmp as 
(
    select
        id as charge_id,
        NULL::integer as index,  -- Snowflake: Explicitly cast NULL to integer
        m.value:id::string as discount_id,  -- Snowflake: Extract JSON key using colon notation
        m.value:code::string as code,
        cast(m.value:value as {{ dbt.type_float() }}) as discount_value,  -- Snowflake: Cast JSON value to float
        m.value:value_type::string as value_type
    FROM 
    {{ source('source_recharge', 'charges') }},
    lateral flatten(input => parse_json(discounts)) m  -- Snowflake: Use LATERAL FLATTEN to unnest JSON array

)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as 
(
    select
        id as charge_id,
        NULL as index,  -- BigQuery: NULL without explicit type casting
        JSON_VALUE(m, '$.id') as discount_id,  -- BigQuery: Extract JSON values with JSON_VALUE
        JSON_VALUE(m, '$.code') as code,
        cast(JSON_VALUE(m, '$.value') as {{ dbt.type_float() }}) as discount_value,  -- BigQuery: Cast JSON value to float
        JSON_VALUE(m, '$.value_type') as value_type
    FROM 
    {{ source('source_recharge', 'charges') }},
    UNNEST (JSON_QUERY_ARRAY(discounts)) m  -- BigQuery: Use UNNEST to expand JSON array

)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as 
(
    select
        id as charge_id,
        NULL::integer as index,  -- Postgres: Explicitly cast NULL to integer
        m.value ->> 'id' as discount_id,  -- Postgres: Extract JSON key as text using ->>
        m.value ->> 'code' as code,
        cast(m.value ->> 'value' as {{ dbt.type_float() }}) as discount_value,  -- Postgres: Cast JSON value to float
        m.value ->> 'value_type' as value_type
    FROM 
    {{ source('source_recharge', 'charges') }},
    jsonb_array_elements(discounts::jsonb) as m(value)  -- Postgres: Use jsonb_array_elements to unnest JSON array

)

select *
from tmp

{% endif %}
