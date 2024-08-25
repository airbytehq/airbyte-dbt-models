WITH tmp AS (
    SELECT
        {{ dbt.current_timestamp() }} AS _fivetran_synced,
        cast(date_created AS {{ dbt.type_timestamp() }}) AS created_at,
        friendly_name,
        sid AS account_id,
        owner_account_sid AS owner_account_id,
        status,
        type,
        cast(date_updated AS {{ dbt.type_timestamp() }}) AS updated_at,
        ROW_NUMBER() OVER (PARTITION BY sid ORDER BY date_updated DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_twilio', 'accounts') }}
)
SELECT * FROM tmp
WHERE account_id IS NOT NULL
