{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS account_note_id,
            account_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS account_updated_at,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            message,
            object,
            created_by AS user_email,
            NULL AS user_id,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
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
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS account_updated_at,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            message,
            object,
            created_by AS user_email,
            NULL AS user_id, -- This field is not present in the original schema
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
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
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS account_updated_at,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            message,
            object,
            created_by AS user_email,
            NULL AS user_id,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_notes') }}
    )
    SELECT * FROM tmp
    WHERE account_note_id IS NOT NULL

{% endif %}
