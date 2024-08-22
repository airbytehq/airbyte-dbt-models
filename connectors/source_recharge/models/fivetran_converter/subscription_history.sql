with tmp as 
(

    select
        id as subscription_id,
        customer_id,
        address_id,
        cast(created_at as {{ dbt.type_timestamp() }}) as subscription_created_at,
        JSON_VALUE(external_product_id, '$.ecommerce') as external_product_id_ecommerce,
        JSON_VALUE(external_variant_id, '$.ecommerce') as external_variant_id_ecommerce,
        product_title,
        variant_title,
        sku,
        cast(price as {{ dbt.type_float() }}) as price,
        quantity,
        status as subscription_status,
        charge_interval_frequency,
        order_interval_unit,
        order_interval_frequency,
        order_day_of_month,
        order_day_of_week,
        expire_after_specific_number_of_charges,
        cast(updated_at as {{ dbt.type_timestamp() }}) as subscription_updated_at,
        cast(next_charge_scheduled_at as {{ dbt.type_timestamp() }}) as subscription_next_charge_scheduled_at,
        cast(cancelled_at as {{ dbt.type_timestamp() }}) as subscription_cancelled_at,
        cancellation_reason,
        cancellation_reason_comments
    FROM 
    {{ source('source_recharge', 'subscriptions') }}, UNNEST (JSON_QUERY_ARRAY(external_product_id)) m

)

select 
    *,
    row_number() over (partition by subscription_id order by subscription_updated_at desc) = 1 as is_most_recent_record
from tmp
