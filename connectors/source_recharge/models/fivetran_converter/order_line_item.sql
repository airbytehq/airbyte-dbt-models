{% if target.type == "snowflake" %}

with tmp as
(
    select
        id as order_id,
        null as index,
        m.value:shopify_product_id::string as external_product_id_ecommerce,
        m.value:shopify_product_id::string as external_variant_id_ecommerce,
        m.value:title::string as order_line_item_title,
        m.value:variant_title::string as product_variant_title,
        m.value:sku::string as sku,
        m.value:quantity::integer as quantity,
        m.value:grams::integer as grams,
        cast(m.value:total_price::float as {{ dbt.type_float() }}) as total_price,
        m.value:unit_price::float as unit_price,
        m.value:tax_due::float as tax_due,
        m.value:taxable::boolean as taxable,
        m.value:taxable_amount::float as taxable_amount,
        m.value:unit_price_includes_tax::boolean as unit_price_includes_tax,
        m.value:purchase_item_id::string as purchase_item_id,
        m.value:purchase_item_type::string as purchase_item_type
    from
    {{ source('source_recharge', 'orders') }} o,
    lateral flatten(input => o.line_items) m -- Unnesting the JSON array
)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as
(
    select
        id as order_id,
        null as index,
        JSON_VALUE(line_items, '$.shopify_product_id') as external_product_id_ecommerce,
        JSON_VALUE(line_items, '$.shopify_product_id') as external_variant_id_ecommerce,
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
        {{ source('source_recharge', 'orders') }} o,
        UNNEST (JSON_QUERY_ARRAY(o.line_items)) line_items
)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as
(
    select
        o.id order_id,
        null as index,
        f.value->>'shopify_product_id' as external_product_id_ecommerce,
        f.value->>'shopify_variant_id' as external_variant_id_ecommerce,
        f.value->>'title' as order_line_item_title,
        f.value->>'variant_title' as product_variant_title,
        f.value->>'sku' as sku,
        (f.value->>'quantity')::int as quantity,
        (f.value->>'grams')::int as grams,
        cast((f.value->>'total_price')::float as {{ dbt.type_float() }}) as total_price,
        f.value->>'unit_price' as unit_price,
        f.value->>'tax_due' as tax_due,
        (f.value->>'taxable')::boolean as taxable,
        f.value->>'taxable_amount' as taxable_amount,
        (f.value->>'unit_price_includes_tax')::boolean as unit_price_includes_tax,
        f.value->>'purchase_item_id' as purchase_item_id,
        f.value->>'purchase_item_type' as purchase_item_type
    from
        {{ source('source_recharge', 'orders') }} o,
        LATERAL jsonb_array_elements(o.line_items::jsonb) AS f(value)
)

select *
from tmp

{% endif %}
