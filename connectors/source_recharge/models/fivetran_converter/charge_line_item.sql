with tmp as 
(
    select
        id as charge_id,
        null as index,
        JSON_VALUE(m, '$.vendor') as vendor
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
        JSON_VALUE(m, '$.purchase_item_type') as purchase_item_type,

    {{ source('source_recharge', 'charges') }}, UNNEST (JSON_QUERY_ARRAY(line_items)) m

)

select *
from tmp

--no info regarding which items are under 'line_items', assume the same as in Fivetran's so unnested them all.
