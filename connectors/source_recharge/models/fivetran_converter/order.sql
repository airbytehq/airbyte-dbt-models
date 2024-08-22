with tmp as 
(

    select
        id as order_id,
        JSON_VALUE(external_order_id, '$.ecommerce') as external_order_id_ecommerce,
        JSON_VALUE(external_order_number, '$.ecommerce') as external_order_number_ecommerce,
        customer_id,
        email,
        cast(created_at as {{ dbt.type_timestamp() }}) as order_created_at,
        status as order_status,
        cast(updated_at as {{ dbt.type_timestamp() }}) as order_updated_at,
        charge_id,
        transaction_id,
        charge_status,
        is_prepaid,
        cast(total_price as {{ dbt.type_float() }}) as order_total_price,
        type as order_type,
        cast(processed_at as {{ dbt.type_timestamp() }}) as order_processed_at,
        cast(scheduled_at as {{ dbt.type_timestamp() }}) as order_scheduled_at,
        cast(shipped_date as {{ dbt.type_timestamp() }}) as order_shipped_date,
        address_id,
        null as is_deleted
    FROM 
    {{ source('source_recharge', 'orders') }}

)

select *
from tmp
