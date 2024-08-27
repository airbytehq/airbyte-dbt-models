WITH tmp AS (
    SELECT
        {{ dbt.current_timestamp() }} AS _fivetran_synced,
        account_sid AS account_id,
        NULL AS area_code_geomatch,
        date_created AS created_at,
        NULL AS fallback_method,
        NULL AS fallback_to_long_code,
        NULL AS fallback_url,
        NULL AS friendly_name,
        messaging_service_sid AS messaging_service_id,
        NULL AS inbound_method,
        NULL AS inbound_request_url,
        NULL AS mms_converter,
        NULL AS scan_message_content,
        NULL AS smart_encoding,
        NULL AS status_callback,
        NULL AS sticky_sender,
        NULL AS synchronous_validation,
        date_updated AS updated_at,
        NULL AS us_app_to_person_registered,
        NULL AS use_inbound_webhook_on_number,
        NULL AS use_case,
        NULL AS validity_period
    FROM
        {{ source('source_twilio', 'messages') }}
)
SELECT * FROM tmp
WHERE messaging_service_id IS NOT NULL
