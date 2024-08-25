WITH tmp AS (
    SELECT
        {{ dbt.current_timestamp() }} AS _fivetran_synced,
        NULL AS account_id,
        NULL AS as_of,
        NULL AS category,
        NULL AS count,
        NULL AS count_unit,
        NULL AS description,
        NULL AS end_date,
        NULL AS price,
        NULL AS price_unit,
        NULL AS start_date,
        NULL AS usage,
        NULL AS usage_unit
    FROM
        {{ source('source_twilio', 'usage_records') }}
)
SELECT * FROM tmp
WHERE account_id IS NOT NULL
