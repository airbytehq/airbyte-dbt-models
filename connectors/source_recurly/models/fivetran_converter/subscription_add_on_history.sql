WITH tmp AS (
    SELECT
        id AS subscription_add_on_id,
        updated_at,
        created_at,
        NULL AS expired_at,
        object,
        plan_id AS plan_add_on_id,
        cast(quantity AS INTEGER) AS quantity,
        cast(subscription_id AS VARCHAR) AS subscription_id,
        cast(unit_amount AS {{ dbt.type_float() }}) AS unit_amount,
        cast(is_most_recent_record AS BOOLEAN) AS is_most_recent_record
    FROM
        {{ source('source_recurly', 'add_ons') }}
)
SELECT * FROM tmp
WHERE subscription_add_on_id IS NOT NULL
