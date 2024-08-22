{% if target.type == "snowflake" %}

with tmp as 
(

    select
        id as subscription_id,
        customer_id,
        address_id,
        cast(created_at as {{ dbt.type_timestamp() }}) as subscription_created_at,
        product_title,
        variant_title,
        sku,
        cast(price as {{ dbt.type_float() }}) as price,
        quantity,
        status as subscription_status,
        next_charge_scheduled_at as subscription_next_charge_scheduled_at,
        charge_interval_frequency,
        expire_after_specific_number_of_charges,
        order_interval_frequency,
        order_interval_unit,
        order_day_of_week,
        order_day_of_month,
        cast(updated_at as {{ dbt.type_timestamp() }}) as subscription_updated_at,
        JSON_VALUE(external_product_id, '$.ecommerce') as external_product_id_ecommerce,
        JSON_VALUE(external_variant_id, '$.ecommerce') as external_variant_id_ecommerce,
        cast(cancelled_at as {{ dbt.type_timestamp() }}) as subscription_cancelled_at,
        cancellation_reason,
        cancellation_reason_comments
    FROM 
    {{ source('source_recharge', 'subscriptions') }}, UNNEST (JSON_QUERY_ARRAY(external_product_id)) m

)

select *
from tmp

{% elif target.type == "bigquery" %}

{% elif target.type == "postgres" %}

{% endif %}