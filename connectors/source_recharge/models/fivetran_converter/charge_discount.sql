with tmp as 
(
    select
        id as charge_id,
        null as index,
        JSON_VALUE(m, '$.id') as discount_id
        JSON_VALUE(m, '$.code') as code,
        cast(JSON_VALUE(m, '$.value') as {{ dbt.type_float() }}) as discount_value,
        JSON_VALUE(m, '$.value_type') as value_type
    {{ source('source_recharge', 'charges') }}, , UNNEST (JSON_QUERY_ARRAY(discounts)) m

)

select *
from tmp