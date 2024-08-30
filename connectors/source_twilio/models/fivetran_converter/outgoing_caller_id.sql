WITH tmp AS (
    SELECT
        {{ dbt.current_timestamp() }} AS _fivetran_synced,
        date_created AS created_at,
        friendly_name,
        sid AS outgoing_caller_id,
        phone_number,
        date_updated
    FROM
        {{ source('source_twilio', 'outgoing_caller_ids') }}
)
SELECT * FROM tmp
