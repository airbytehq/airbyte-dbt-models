{% if target.type == "snowflake" %}

with frst as (
    select 
        line_items 
    from {{ source('source_recharge', 'orders') }}
),
tmp as 
(
    select
        value:$.id::string as order_id,
        null as index,
        value:$.ecommerce::string as external_product_id_ecommerce,
        value:$.ecommerce::string as external_variant_id_ecommerce,
        value:$.title::string as order_line_item_title,
        value:$.variant_title::string as product_variant_title,
        value:$.sku::string as sku,
        value:$.quantity::integer as quantity,
        value:$.grams::integer as grams,
        cast(value:$.total_price::float as {{ dbt.type_float() }}) as total_price,
        value:$.unit_price::float as unit_price,
        value:$.tax_due::float as tax_due,
        value:$.taxable::boolean as taxable,
        value:$.taxable_amount::float as taxable_amount,
        value:$.unit_price_includes_tax::boolean as unit_price_includes_tax,
        value:$.purchase_item_id::string as purchase_item_id,
        value:$.purchase_item_type::string as purchase_item_type
    from 
    frst,
    lateral flatten(input => frst.line_items) as value -- Unnesting the JSON array
)

select *
from tmp

{% elif target.type == "bigquery" %}

with 
frst as (
    select 
        line_items 
    from {{ source('source_recharge', 'orders') }}
),
tmp as 
(
    select
        JSON_VALUE(line_items, '$.id') as order_id,
        null as index,
        JSON_VALUE(m, '$.ecommerce') as external_product_id_ecommerce,
        JSON_VALUE(n, '$.ecommerce') as external_variant_id_ecommerce,
        JSON_VALUE(line_items, '$.title') as order_line_item_title,
        JSON_VALUE(line_items, '$.variant_title') as product_variant_title,
        JSON_VALUE(line_items, '$.sku') as sku,
        JSON_VALUE(line_items, '$.quantity') as quantity,
        JSON_VALUE(line_items, '$.grams') as grams,
        cast(JSON_VALUE(line_items, '$.total_price') as {{ dbt.type_float() }}) as total_price,
        JSON_VALUE(line_items, '$.unit_price') as unit_price,
        JSON_VALUE(line_items, '$.tax_due') as tax_due,
        JSON_VALUE(line_items, '$.taxable') as taxable,
        JSON_VALUE(line_items, '$.taxable_amount') as taxable_amount,
        JSON_VALUE(line_items, '$.unit_price_includes_tax') as unit_price_includes_tax,
        JSON_VALUE(line_items, '$.purchase_item_id') as purchase_item_id,
        JSON_VALUE(line_items, '$.purchase_item_type') as purchase_item_type
    from 
    frst,  
    UNNEST (JSON_QUERY_ARRAY(external_product_id)) m,
    UNNEST (JSON_QUERY_ARRAY(external_variant_id)) n -- Unnesting line_items
)

select *
from tmp

{% elif target.type == "postgres" %}

with frst as (
    select 
        line_items 
    from {{ source('source_recharge', 'orders') }}
),
tmp as 
(
    select
        line_items->>'id' as order_id,
        null as index,
        m.value->>'ecommerce' as external_product_id_ecommerce,
        n.value->>'ecommerce' as external_variant_id_ecommerce,
        line_items->>'title' as order_line_item_title,
        line_items->>'variant_title' as product_variant_title,
        line_items->>'sku' as sku,
        (line_items->>'quantity')::int as quantity,
        (line_items->>'grams')::int as grams,
        cast((line_items->>'total_price')::float as {{ dbt.type_float() }}) as total_price,
        line_items->>'unit_price' as unit_price,
        line_items->>'tax_due' as tax_due,
        (line_items->>'taxable')::boolean as taxable,
        line_items->>'taxable_amount' as taxable_amount,
        (line_items->>'unit_price_includes_tax')::boolean as unit_price_includes_tax,
        line_items->>'purchase_item_id' as purchase_item_id,
        line_items->>'purchase_item_type' as purchase_item_type
    from 
    frst,  
    jsonb_array_elements(line_items->'external_product_id') as m,
    jsonb_array_elements(line_items->'external_variant_id') as n -- Unnesting line_items
)

select *
from tmp

{% endif %}
