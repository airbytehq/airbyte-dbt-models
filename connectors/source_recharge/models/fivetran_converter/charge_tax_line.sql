with tmp as 
(
    select
        id as charge_id,
        null as index,
        JSON_VALUE(tax_lines, '$.price') as price
        JSON_VALUE(tax_lines, '$.rate') as rate,
        JSON_VALUE(tax_lines, '$.title') as title
    {{ source('source_recharge', 'charges') }}

)

select *
from tmp

--no info regarding which items are under 'tax_lines' (they are in string format, not array),  assume the same as in Fivetran's so unnested them all.
