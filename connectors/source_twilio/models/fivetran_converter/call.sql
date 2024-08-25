{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            {{ dbt.current_timestamp() }} AS _fivetran_synced,
            account_sid AS account_id,
            annotation,
            answered_by,
            caller_name,
            cast(date_created AS {{ dbt.type_timestamp() }}) AS created_at,
            direction,
            cast({{ twilio_source.remove_non_numeric_chars('duration') }} AS {{ dbt.type_float() }}) AS duration,
            cast(end_time AS {{ dbt.type_timestamp() }}) AS end_time,
            forwarded_from,
            "from" AS call_from,
            from_formatted,
            group_sid AS group_id,
            sid AS call_id,
            phone_number_sid AS outgoing_caller_id,
            parent_call_sid AS parent_call_id,
            cast({{ twilio_source.remove_non_numeric_chars('price') }} AS {{ dbt.type_float() }}) AS price,
            price_unit,
            cast({{ twilio_source.remove_non_numeric_chars('queue_time') }} AS {{ dbt.type_float() }}) AS queue_time,
            cast(start_time AS {{ dbt.type_timestamp() }}) AS start_time,
            status,
            "to" AS call_to,
            to_formatted,
            trunk_sid AS trunk_id,
            cast(date_updated AS {{ dbt.type_timestamp() }}) AS updated_at
        FROM
            {{ source('source_twilio', 'calls') }}
    )
    SELECT * FROM tmp
    WHERE call_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            {{ dbt.current_timestamp() }} AS _fivetran_synced,
            account_sid AS account_id,
            annotation,
            answered_by,
            caller_name,
            cast(date_created AS {{ dbt.type_timestamp() }}) AS created_at,
            direction,
            cast({{ twilio_source.remove_non_numeric_chars('duration') }} AS {{ dbt.type_float() }}) AS duration,
            cast(end_time AS {{ dbt.type_timestamp() }}) AS end_time,
            forwarded_from,
            `from` AS call_from,
            from_formatted,
            group_sid AS group_id,
            sid AS call_id,
            phone_number_sid AS outgoing_caller_id,
            parent_call_sid AS parent_call_id,
            cast({{ twilio_source.remove_non_numeric_chars('price') }} AS {{ dbt.type_float() }}) AS price,
            price_unit,
            cast({{ twilio_source.remove_non_numeric_chars('queue_time') }} AS {{ dbt.type_float() }}) AS queue_time,
            cast(start_time AS {{ dbt.type_timestamp() }}) AS start_time,
            status,
            `to` AS call_to,
            to_formatted,
            trunk_sid AS trunk_id,
            cast(date_updated AS {{ dbt.type_timestamp() }}) AS updated_at
        FROM
            {{ source('source_twilio', 'calls') }}
    )
    SELECT * FROM tmp
    WHERE call_id IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            {{ dbt.current_timestamp() }} AS _fivetran_synced,
            account_sid AS account_id,
            annotation,
            answered_by,
            caller_name,
            cast(date_created AS {{ dbt.type_timestamp() }}) AS created_at,
            direction,
            cast({{ twilio_source.remove_non_numeric_chars('duration') }} AS {{ dbt.type_float() }}) AS duration,
            cast(end_time AS {{ dbt.type_timestamp() }}) AS end_time,
            forwarded_from,
            "from" AS call_from,
            from_formatted,
            group_sid AS group_id,
            sid AS call_id,
            phone_number_sid AS outgoing_caller_id,
            parent_call_sid AS parent_call_id,
            cast({{ twilio_source.remove_non_numeric_chars('price') }} AS {{ dbt.type_float() }}) AS price,
            price_unit,
            cast({{ twilio_source.remove_non_numeric_chars('queue_time') }} AS {{ dbt.type_float() }}) AS queue_time,
            cast(start_time AS {{ dbt.type_timestamp() }}) AS start_time,
            status,
            "to" AS call_to,
            to_formatted,
            trunk_sid AS trunk_id,
            cast(date_updated AS {{ dbt.type_timestamp() }}) AS updated_at
        FROM
            {{ source('source_twilio', 'calls') }}
    )
    SELECT * FROM tmp
    WHERE call_id IS NOT NULL

{% endif %}
