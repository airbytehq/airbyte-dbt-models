with tmp as 
(
    select
        id as charge_id,
        null as index,
        order_attributes as order_attribute
    {{ source('source_recharge', 'charges') }}

)

select *
from tmp
