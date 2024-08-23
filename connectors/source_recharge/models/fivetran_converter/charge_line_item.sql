{% if target.type == "snowflake" %}

with tmp as 
(
    select
        id as charge_id,
        NULL::integer as index,  -- Snowflake: Explicitly cast NULL to integer
        m.value:vendor::string as vendor,  -- Snowflake: Extract JSON keys using colon notation and cast to appropriate types
        m.value:title::string as title,
        m.value:variant_title::string as variant_title,
        m.value:sku::string as sku,
        m.value:grams::number as grams,
        m.value:quantity::number as quantity,
        CAST(m.value:total_price::string AS {{ dbt.type_float() }}) as total_price,  -- Snowflake: Cast JSON value to float
        m.value:unit_price::string as unit_price,
        m.value:tax_due::string as tax_due,
        m.value:taxable::string as taxable,
        m.value:taxable_amount::string as taxable_amount,
        m.value:unit_price_includes_tax::string as unit_price_includes_tax,
        m.value:external_product_id_ecommerce::string as external_product_id_ecommerce,
        m.value:external_variant_id_ecommerce::string as external_variant_id_ecommerce,
        m.value:purchase_item_id::string as purchase_item_id,
        m.value:purchase_item_type::string as purchase_item_type

    FROM 
    {{ source('source_recharge', 'charges') }},
    lateral flatten(input => parse_json(line_items)) m  -- Snowflake: Use LATERAL FLATTEN to unnest JSON array

)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as 
(
    select
        id as charge_id,
        null as index,
        JSON_VALUE(m, '$.vendor') as vendor,
        JSON_VALUE(m, '$.title') as title,
        JSON_VALUE(m, '$.variant_title') as variant_title,
        JSON_VALUE(m, '$.sku') as sku,
        JSON_VALUE(m, '$.grams') as grams,
        JSON_VALUE(m, '$.quantity') as quantity,
        CAST(JSON_VALUE(m, '$.total_price') as {{ dbt.type_float() }}) as total_price,
        JSON_VALUE(m, '$.unit_price') as unit_price,
        JSON_VALUE(m, '$.tax_due') as tax_due,
        JSON_VALUE(m, '$.taxable') as taxable,
        JSON_VALUE(m, '$.taxable_amount') as taxable_amount,
        JSON_VALUE(m, '$.unit_price_includes_tax') as unit_price_includes_tax,
        JSON_VALUE(m, '$.external_product_id_ecommerce') as external_product_id_ecommerce,
        JSON_VALUE(m, '$.external_variant_id_ecommerce') as external_variant_id_ecommerce,
        JSON_VALUE(m, '$.purchase_item_id') as purchase_item_id,
        JSON_VALUE(m, '$.purchase_item_type') as purchase_item_type

    FROM 
    {{ source('source_recharge', 'charges') }},
    UNNEST (JSON_QUERY_ARRAY(line_items)) m  -- BigQuery: Use UNNEST to expand JSON array

)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as 
(
    select
        id as charge_id,
        NULL::integer as index,  -- Postgres: Explicitly cast NULL to integer
        m.value ->> 'vendor' as vendor,  -- Postgres: Extract JSON key as text using ->>
        m.value ->> 'title' as title,
        m.value ->> 'variant_title' as variant_title,
        m.value ->> 'sku' as sku,
        m.value ->> 'grams' as grams,
        m.value ->> 'quantity' as quantity,
        CAST(m.value ->> 'total_price' as {{ dbt.type_float() }}) as total_price,  -- Postgres: Cast JSON value to float
        m.value ->> 'unit_price' as unit_price,
        m.value ->> 'tax_due' as tax_due,
        m.value ->> 'taxable' as taxable,
        m.value ->> 'taxable_amount' as taxable_amount,
        m.value ->> 'unit_price_includes_tax' as unit_price_includes_tax,
        m.value ->> 'external_product_id_ecommerce' as external_product_id_ecommerce,
        m.value ->> 'external_variant_id_ecommerce' as external_variant_id_ecommerce,
        m.value ->> 'purchase_item_id' as purchase_item_id,
        m.value ->> 'purchase_item_type' as purchase_item_type

    FROM 
    {{ source('source_recharge', 'charges') }},
    jsonb_array_elements(line_items::jsonb) as m(value)  -- Postgres: Use jsonb_array_elements to unnest JSON array

)

select *
from tmp

{% endif %}
