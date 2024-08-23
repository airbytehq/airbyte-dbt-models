{% if target.type == "snowflake" %}

with tmp as 
(
    select
        id as charge_id,
        NULL::integer as index,  -- Snowflake: Explicitly cast NULL to integer
        t.value:price::string as price,  -- Snowflake: Extract JSON keys using colon notation and cast to appropriate types
        t.value:rate::string as rate,
        t.value:title::string as title
    FROM 
    {{ source('source_recharge', 'charges') }},
    lateral flatten(input => parse_json(tax_lines)) t  -- Snowflake: Use LATERAL FLATTEN to unnest JSON objects

)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as 
(
    select
        id as charge_id,
        null as index,  -- BigQuery: NULL without explicit type casting
        JSON_VALUE(tax_lines, '$.price') as price,  -- BigQuery: Extract JSON values with JSON_VALUE
        JSON_VALUE(tax_lines, '$.rate') as rate,
        JSON_VALUE(tax_lines, '$.title') as title
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
        (jsonb_each_text(tax_lines::jsonb)).value ->> 'price' as price,  -- Postgres: Extract JSON keys from text
        (jsonb_each_text(tax_lines::jsonb)).value ->> 'rate' as rate,
        (jsonb_each_text(tax_lines::jsonb)).value ->> 'title' as title
    FROM 
    {{ source('source_recharge', 'charges') }}

)

select *
from tmp

{% endif %}
