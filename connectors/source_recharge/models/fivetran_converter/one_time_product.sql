{% if target.type == "snowflake" %}

with tmp as 
(
    select
        id as one_time_product_id,
        address_id,
        customer_id,
        null as is_deleted,
        cast(created_at as {{ dbt.type_timestamp() }}) as one_time_created_at,
        cast(updated_at as {{ dbt.type_timestamp() }}) as one_time_updated_at,
        next_charge_scheduled_at as one_time_next_charge_scheduled_at,
        product_title,
        variant_title,
        price,
        quantity,
        shopify_product_id as external_product_id_ecommerce,
        shopify_variant_id as external_variant_id_ecommerce,
        sku
    from 
    {{ source('source_recharge', 'onetimes') }}
)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as 
(
    select
        id as one_time_product_id,
        address_id,
        customer_id,
        null as is_deleted,
        cast(created_at as {{ dbt.type_timestamp() }}) as one_time_created_at,
        cast(updated_at as {{ dbt.type_timestamp() }}) as one_time_updated_at,
        next_charge_scheduled_at as one_time_next_charge_scheduled_at,
        product_title,
        variant_title,
        price,
        quantity,
        shopify_product_id as external_product_id_ecommerce,
        shopify_variant_id as external_variant_id_ecommerce,
        sku
    from 
    {{ source('source_recharge', 'onetimes') }}
)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as 
(
    select
        id as one_time_product_id,
        address_id,
        customer_id,
        null as is_deleted,
        cast(created_at as {{ dbt.type_timestamp() }}) as one_time_created_at,
        cast(updated_at as {{ dbt.type_timestamp() }}) as one_time_updated_at,
        next_charge_scheduled_at as one_time_next_charge_scheduled_at,
        product_title,
        variant_title,
        price,
        quantity,
        shopify_product_id as external_product_id_ecommerce,
        shopify_variant_id as external_variant_id_ecommerce,
        sku
    from 
    {{ source('source_recharge', 'onetimes') }}
)

select *
from tmp

{% endif %}
