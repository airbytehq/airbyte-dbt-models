{% if target.type == "snowflake" %}

with tmp as 
(
    select
        id as charge_id,
        null as index,
        JSON_VALUE(m, '$.price') as price
        JSON_VALUE(m, '$.code') as code,
        JSON_VALUE(m, '$.title') as title
    {{ source('source_recharge', 'charges') }}, UNNEST (JSON_QUERY_ARRAY(shipping_lines)) m

)

select *
from tmp

--no info regarding which items are under 'shipping_lines', assume the same as in Fivetran's so unnested them all.

{% elif target.type == "bigquery" %}

{% elif target.type == "postgres" %}

{% endif %}