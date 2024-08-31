SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    cast(date_created AS {{ dbt.type_timestamp() }}) AS created_at,
    friendly_name,
    sid AS id,
    owner_account_sid AS owner_account_id,
    status,
    type,
    cast(date_updated AS {{ dbt.type_timestamp() }}) AS updated_at
FROM
    {{ source('source_twilio', 'accounts') }}

