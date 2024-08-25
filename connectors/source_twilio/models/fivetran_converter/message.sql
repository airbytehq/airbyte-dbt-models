WITH tmp AS (
    SELECT
        {{ dbt.current_timestamp() }} AS _fivetran_synced,
        account_sid AS account_id,
        body,
        cast(date_created AS {{ dbt.type_timestamp() }}) AS created_at,
        cast(date_sent AS {{ dbt.type_timestamp() }}) AS timestamp_sent,
        direction,
        error_code,
        error_message,
        "from" AS message_from,
        sid AS message_id,
        cast(messaging_service_sid AS {{ dbt.type_string() }}) AS messaging_service_id,
        num_media,
        num_segments,
        price,
        price_unit,
        status,
        "to" AS message_to,
        cast(date_updated AS {{ dbt.type_timestamp() }}) AS updated_at
    FROM
        {{ source('source_twilio', 'messages') }}
)
SELECT * FROM tmp
WHERE message_id IS NOT NULL
