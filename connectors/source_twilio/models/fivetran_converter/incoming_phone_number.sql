{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            {{ dbt.current_timestamp() }} AS _fivetran_synced,
            account_sid AS account_id,
            cast(address_sid AS {{ dbt.type_string() }}) AS address_id,
            capabilities:mms::boolean AS capabilities_mms,
            capabilities:sms::boolean AS capabilities_sms,
            capabilities:voice::boolean AS capabilities_voice,
            cast(date_created AS {{ dbt.type_timestamp() }}) AS created_at,
            emergency_address_sid AS emergency_address_id,
            emergency_status,
            friendly_name,
            sid AS incoming_phone_number_id,
            origin,
            phone_number,
            trunk_sid AS trunk_id,
            cast(date_updated AS {{ dbt.type_timestamp() }}) AS updated_at,
            voice_caller_id_lookup,
            voice_url
        FROM
            {{ source('source_twilio', 'incoming_phone_numbers') }}
    )
    SELECT * FROM tmp
    WHERE incoming_phone_number_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            {{ dbt.current_timestamp() }} AS _fivetran_synced,
            account_sid AS account_id,
            cast(address_sid AS {{ dbt.type_string() }}) AS address_id,
            JSON_EXTRACT_SCALAR(capabilities, '$.mms') = 'true' AS capabilities_mms,
            JSON_EXTRACT_SCALAR(capabilities, '$.sms') = 'true' AS capabilities_sms,
            JSON_EXTRACT_SCALAR(capabilities, '$.voice') = 'true' AS capabilities_voice,
            cast(date_created AS {{ dbt.type_timestamp() }}) AS created_at,
            emergency_address_sid AS emergency_address_id,
            emergency_status,
            friendly_name,
            sid AS incoming_phone_number_id,
            origin,
            phone_number,
            trunk_sid AS trunk_id,
            cast(date_updated AS {{ dbt.type_timestamp() }}) AS updated_at,
            voice_caller_id_lookup,
            voice_url
        FROM
            {{ source('source_twilio', 'incoming_phone_numbers') }}
    )
    SELECT * FROM tmp
    WHERE incoming_phone_number_id IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            {{ dbt.current_timestamp() }} AS _fivetran_synced,
            account_sid AS account_id,
            cast(address_sid AS {{ dbt.type_string() }}) AS address_id,
            (capabilities->>'mms')::boolean AS capabilities_mms,
            (capabilities->>'sms')::boolean AS capabilities_sms,
            (capabilities->>'voice')::boolean AS capabilities_voice,
            cast(date_created AS {{ dbt.type_timestamp() }}) AS created_at,
            emergency_address_sid AS emergency_address_id,
            emergency_status,
            friendly_name,
            sid AS incoming_phone_number_id,
            origin,
            phone_number,
            trunk_sid AS trunk_id,
            cast(date_updated AS {{ dbt.type_timestamp() }}) AS updated_at,
            voice_caller_id_lookup,
            voice_url
        FROM
            {{ source('source_twilio', 'incoming_phone_numbers') }}
    )
    SELECT * FROM tmp
    WHERE incoming_phone_number_id IS NOT NULL

{% endif %}
