SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    account_sid AS account_id,
    city,
    cast(date_created AS {{ dbt.type_timestamp() }}) AS created_at,
    customer_name,
    emergency_enabled,
    friendly_name,
    cast(sid AS {{ dbt.type_string() }}) AS address_id,
    iso_country,
    postal_code,
    region,
    street,
    cast(date_updated AS {{ dbt.type_timestamp() }}) AS updated_at,
    validated,
    verified
FROM
    {{ source('source_twilio', 'addresses') }}
WHERE sid IS NOT NULL