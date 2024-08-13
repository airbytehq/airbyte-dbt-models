{% if target.type == "snowflake" %}

with tmp as 
(

    select
        id as address_id,
        customer_id,
        first_name,
        last_name,
        cast(created_at as {{ dbt.type_timestamp() }}) as address_created_at,
        cast(updated_at as {{ dbt.type_timestamp() }}) as address_updated_at,
        address_1 as address_line_1,
        address_2 as address_line_2,
        city,
        province,
        zip,
        country_code,
        company,
        phone

    FROM 
    {{ source('source_recharge', 'addresses') }}

)

select *
from tmp

{% elif target.type == "bigquery" %}

with tmp as 
(

    select
        id as address_id,
        customer_id,
        first_name,
        last_name,
        cast(created_at as {{ dbt.type_timestamp() }}) as address_created_at,
        cast(updated_at as {{ dbt.type_timestamp() }}) as address_updated_at,
        address_1 as address_line_1,
        address_2 as address_line_2,
        city,
        province,
        zip,
        country_code,
        company,
        phone

    FROM 
    {{ source('source_recharge', 'addresses') }}

)

select *
from tmp

{% elif target.type == "postgres" %}

with tmp as 
(

    select
        id as address_id,
        customer_id,
        first_name,
        last_name,
        cast(created_at as {{ dbt.type_timestamp() }}) as address_created_at,
        cast(updated_at as {{ dbt.type_timestamp() }}) as address_updated_at,
        address_1 as address_line_1,
        address_2 as address_line_2,
        city,
        province,
        zip,
        country_code,
        company,
        phone

    FROM 
    {{ source('source_recharge', 'addresses') }}

)

select *
from tmp

{% endif %}