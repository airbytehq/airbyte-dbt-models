{% if target.type == "snowflake" %}

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

{% elif target.type == "bigquery" %}

{% elif target.type == "postgres" %}

{% endif %}