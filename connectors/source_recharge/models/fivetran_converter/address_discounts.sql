with tmp as 
(

    select
        discount_id,
        id as address_id,
        NULL as index

    FROM 
    {{ source('source_recharge', 'addresses') }}

)

select *
from tmp