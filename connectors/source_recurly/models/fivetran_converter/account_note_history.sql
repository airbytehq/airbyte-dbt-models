{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS account_note_id,
            account_id,
            user->>created_at AS account_updated_at,
            user->>created_at AS created_at,
            message,
            object,
            user->>email AS user_email,
            user->>id AS user_id,
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
            user:created_at::string AS account_updated_at,
            user:created_at::string AS created_at,
            message,
            object,
            user:email::string AS user_email,
            user:id::string AS user_id,
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
            JSON_EXTRACT_SCALAR(user, '$.created_at') AS account_updated_at,
            JSON_EXTRACT_SCALAR(user, '$.created_at') AS created_at,
            message,
            object,
            JSON_EXTRACT_SCALAR(user, '$.email') AS user_email,
            JSON_EXTRACT_SCALAR(user, '$.id') AS user_id,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY created_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_notes') }}
    )
    SELECT * FROM tmp
    WHERE account_note_id IS NOT NULL

{% endif %}
