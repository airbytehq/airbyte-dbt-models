{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            {{ dbt.current_timestamp() }} AS _fivetran_synced,
            NULL AS created_at,
            NULL AS friendly_name,
            NULL AS outgoing_caller_id,
            NULL AS phone_number,
            NULL AS updated_at
        FROM
            {{ source('source_twilio', 'outgoing_caller_ids') }}
    )
    SELECT * FROM tmp

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            {{ dbt.current_timestamp() }} AS _fivetran_synced,
            NULL AS created_at,
            NULL AS friendly_name,
            NULL AS outgoing_caller_id,
            NULL AS phone_number,
            NULL AS updated_at
        FROM
            {{ source('source_twilio', 'outgoing_caller_ids') }}
    )
    SELECT * FROM tmp

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            {{ dbt.current_timestamp() }} AS _fivetran_synced,
            NULL AS created_at,
            NULL AS friendly_name,
            NULL AS outgoing_caller_id,
            NULL AS phone_number,
            NULL AS updated_at
        FROM
            {{ source('source_twilio', 'outgoing_caller_ids') }}
    )
    SELECT * FROM tmp

{% endif %}
