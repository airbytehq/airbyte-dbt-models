with tmp as 
(

    select
        id as address_id,
        NULL as index,
        JSON_VALUE(m, '$.price') as price,
        JSON_VALUE(m, '$.code') as code,
        JSON_VALUE(m, '$.title') as title
    FROM 
    {{ source('source_recharge', 'addresses') }}, UNNEST (JSON_QUERY_ARRAY(shipping_lines_override)) m

)

select *
from tmp