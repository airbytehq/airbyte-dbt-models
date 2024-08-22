with tmp as 
(

    select
        id as order_id,
        null as index,
        JSON_VALUE(external_product_id, '$.ecommerce') as external_product_id_ecommerce,
        JSON_VALUE(external_variant_id, '$.ecommerce') as external_variant_id_ecommerce,
        title as order_line_item_title,
        variant_title as product_variant_title,
        sku,
        quantity,
        grams,
        cast(total_price as {{ dbt.type_float() }}) as total_price,
        unit_price,
        tax_due,
        taxable,
        taxable_amount,
        unit_price_includes_tax,
        purchase_item_id,
        purchase_item_type
    FROM 
    {{ source('source_recharge', 'orders') }} --unnest line_items

)

select *
from tmp
