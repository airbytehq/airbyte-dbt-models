{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS account_note_id,
            account_id,
            NULL AS account_updated_at,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            message,
            object,
            NULL AS user_email,
            NULL AS user_id,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY created_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_notes') }}
    )
    SELECT * FROM tmp
    WHERE account_note_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS account_note_id,
            account_id,
            NULL AS account_updated_at,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            message,
            object,
            NULL AS user_email,
            NULL AS user_id, 
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY created_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_notes') }}
    )
    SELECT * FROM tmp
    WHERE account_note_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS account_note_id,
            account_id,
            NULL AS account_updated_at,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            message,
            object,
            NULL AS user_email,
            NULL AS user_id,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY created_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_notes') }}
    )
    SELECT * FROM tmp
    WHERE account_note_id IS NOT NULL

{% endif %}
