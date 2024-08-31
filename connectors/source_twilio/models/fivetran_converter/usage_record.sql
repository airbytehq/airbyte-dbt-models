WITH tmp AS (
    SELECT
        {{ dbt.current_timestamp() }} AS _fivetran_synced,
        account_sid AS account_id,
        cast(as_of AS {{ dbt.type_timestamp() }}) AS as_of,
        category,
        cast(count AS {{ dbt.type_int() }}) AS count,
        count_unit,
        description,
        end_date,
        cast(price AS {{ dbt.type_float() }}) AS price,
        price_unit,
        cast(start_date as date) AS start_date,
        cast(usage AS {{ dbt.type_float() }}) AS usage,
        usage_unit
    FROM
        {{ source('source_twilio', 'usage_records') }}
)
SELECT * FROM tmp
WHERE account_id IS NOT NULL
