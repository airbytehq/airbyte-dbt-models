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
    {{ source('source_recharge', 'charges') }} c,
    lateral flatten(input => parse_json(c.tax_lines)) t  -- Snowflake: Use LATERAL FLATTEN to unnest JSON objects

)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as
(
    select
        id as charge_id,
        null as index,  -- BigQuery: NULL without explicit type casting
        JSON_VALUE(f, '$.price') as price,  -- BigQuery: Extract JSON values with JSON_VALUE
        JSON_VALUE(f, '$.rate') as rate,
        JSON_VALUE(f, '$.title') as title
    FROM
    {{ source('source_recharge', 'charges') }} c,
    UNNEST(JSON_EXTRACT_ARRAY(c.tax_lines)) AS f

)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as
(
    select
        id as charge_id,
        NULL::integer as index,  -- Postgres: Explicitly cast NULL to integer
        f.value ->> 'price' as price,  -- Postgres: Extract JSON keys from text
        f.value ->> 'rate' as rate,
        f.value ->> 'title' as title
    FROM
    {{ source('source_recharge', 'charges') }} c,
    LATERAL jsonb_array_elements(c.tax_lines::jsonb) AS f(value)


)

select *
from tmp

{% endif %}
