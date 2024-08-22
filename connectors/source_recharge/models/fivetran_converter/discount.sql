with tmp as 
(

    select
        id as discount_id,
        cast(created_at as {{ dbt.type_timestamp() }}) as discount_created_at,
        cast(updated_at as {{ dbt.type_timestamp() }}) as discount_updated_at,
        cast(starts_at as {{ dbt.type_timestamp() }}) as discount_starts_at,
        cast(ends_at as {{ dbt.type_timestamp() }}) as discount_ends_at,
        code,
        value,
        status,
        usage_limit as usage_limits,
        applies_to,
        applies_to_resource,
        applies_to_id,
        applies_to_product_type,
        null as minimum_order_amount
    FROM 
    {{ source('source_recharge', 'discounts') }}

)

select *
from tmp
