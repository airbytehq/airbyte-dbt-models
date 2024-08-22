with tmp as 
(

    select
        id as customer_id,
        hash as customer_hash,
        JSON_VALUE(external_customer_id, '$.ecommerce') as external_customer_id_ecommerce,
        email,
        first_name,
        last_name,
        cast(created_at as {{ dbt.type_timestamp() }}) as customer_created_at,
        cast(updated_at as {{ dbt.type_timestamp() }}) as customer_updated_at,
        cast(first_charge_processed_at as {{ dbt.type_timestamp() }}) as first_charge_processed_at,
        subscriptions_active_count,
        subscriptions_total_count,
        has_valid_payment_method,
        has_payment_method_in_dunning,
        tax_exempt,
        billing_first_name,
        billing_last_name,
        billing_company,
        billing_city,
        billing_country
    FROM 
    {{ source('source_recharge', 'customers') }}

)

select *
from tmp
