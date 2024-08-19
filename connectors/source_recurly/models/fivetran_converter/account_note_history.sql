WITH tmp AS (
    SELECT
        id AS account_note_id,
        account_id,
        updated_at AS account_updated_at,
        cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
        message,
        object,
        created_by AS user_email,
        created_by AS user_id,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY created_at DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_recurly', 'account_notes') }}
)
SELECT * FROM tmp
WHERE account_note_id IS NOT NULL

