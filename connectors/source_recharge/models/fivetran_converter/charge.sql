{% if target.type == "snowflake" %}

with tmp as
(
    select
        id,
        customer_id,
        customer_hash,
        email,
        cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
        type as charge_type,
        status as charge_status,
        cast(updated_at as {{ dbt.type_timestamp() }}) as updated_at,
        note,
        subtotal_price,
        tax_lines,
        cast(total_discounts as {{ dbt.type_float() }}) as total_discounts,
        total_line_items_price,
        total_tax,
        cast(total_price as {{ dbt.type_float() }}) as total_price,
        cast(total_refunds as {{ dbt.type_float() }}) as total_refunds,
        cast(total_weight_grams as {{ dbt.type_float() }}) as total_weight_grams,
        cast(scheduled_at as {{ dbt.type_timestamp() }}) as scheduled_at,
        cast(processed_at as {{ dbt.type_timestamp() }}) as processed_at,
        payment_processor,
        to_variant(external_transaction_id):payment_processor as external_transaction_id_payment_processor,
        to_variant(external_order_id):ecommerce as external_order_id_ecommerce,
        orders_count,
        has_uncommitted_changes,
        cast(retry_date as {{ dbt.type_timestamp() }}) as retry_date,
        error_type,
        charge_attempts as times_retried,
        address_id,
        to_variant(client_details):browser_ip as client_details_browser_ip,
        to_variant(client_details):user_agent as client_details_user_agent,
        tags,
        error,
        external_variant_id_not_found
    from
    {{ source('source_recharge', 'charges') }}
)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as
(

    select
        id,
        customer_id,
        customer_hash,
        email,
        cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
        type as charge_type,
        status as charge_status,
        cast(updated_at as {{ dbt.type_timestamp() }}) as updated_at,
        note,
        cast(null as {{dbt.type_float()}}) as tax_lines,
        cast(subtotal_price as {{ dbt.type_float() }}) as subtotal_price,
        cast(total_discounts as {{ dbt.type_float() }}) as total_discounts,
        cast(total_line_items_price as {{ dbt.type_float() }}) as total_line_items_price,
        cast(total_tax as {{ dbt.type_float() }}) as total_tax,
        cast(total_price as {{ dbt.type_float() }}) as total_price,
        cast(total_refunds as {{ dbt.type_float() }}) as total_refunds,
        cast(total_weight_grams as {{ dbt.type_float() }}) as total_weight_grams,
        cast(scheduled_at as {{ dbt.type_timestamp() }}) as scheduled_at,
        cast(processed_at as {{ dbt.type_timestamp() }}) as processed_at,
        payment_processor,
        JSON_VALUE(external_transaction_id, '$.payment_processor') as external_transaction_id_payment_processor,
        JSON_VALUE(external_order_id, '$.ecommerce') as external_order_id_ecommerce,
        orders_count,
        has_uncommitted_changes,
        cast(retry_date as {{ dbt.type_timestamp() }}) as retry_date,
        error_type,
        charge_attempts as times_retried,
        address_id,
        JSON_VALUE(client_details, '$.browser_ip')as client_details_browser_ip,
        JSON_VALUE(client_details, '$.user_agent') as client_details_user_agent,
        tags,
        error,
        external_variant_id_not_found

    FROM
    {{ source('source_recharge', 'charges') }}

)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as
(
    select
        id,
        customer_id,
        customer_hash,
        email,
        cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
        type as charge_type,
        status as charge_status,
        cast(updated_at as {{ dbt.type_timestamp() }}) as updated_at,
        note,
        cast(null as {{ dbt.type_float() }}) as tax_lines,
        cast(subtotal_price as {{ dbt.type_float() }}) as subtotal_price,
        cast(total_discounts as {{ dbt.type_float() }}) as total_discounts,
        cast(total_line_items_price as {{ dbt.type_float() }}) as total_line_items_price,
        cast(total_tax as {{ dbt.type_float() }}) as total_tax,
        cast(total_price as {{ dbt.type_float() }}) as total_price,
        cast(total_refunds as {{ dbt.type_float() }}) as total_refunds,
        cast(total_weight_grams as {{ dbt.type_float() }}) as total_weight_grams,
        cast(scheduled_at as {{ dbt.type_timestamp() }}) as scheduled_at,
        cast(processed_at as {{ dbt.type_timestamp() }}) as processed_at,
        payment_processor,
        external_transaction_id->>'payment_processor' as external_transaction_id_payment_processor,
        external_order_id->>'ecommerce' as external_order_id_ecommerce,
        orders_count,
        has_uncommitted_changes,
        cast(retry_date as {{ dbt.type_timestamp() }}) as retry_date,
        error_type,
        charge_attempts,
        address_id,
        client_details->>'browser_ip' as client_details_browser_ip,
        client_details->>'user_agent' as client_details_user_agent,
        tags,
        error,
        external_variant_id_not_found

    from
    {{ source('source_recharge', 'charges') }}
)

select *
from tmp

{% endif %}
