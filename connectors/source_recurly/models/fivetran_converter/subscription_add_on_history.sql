WITH tmp AS (
    SELECT
        id AS subscription_add_on_id,
        cast(updated_at AS TIMESTAMP) AS updated_at,
        cast(created_at AS TIMESTAMP) AS created_at,
        cast(expired_at AS TIMESTAMP) AS expired_at,
        object AS object,
        plan_id AS plan_add_on_id,
        cast(quantity AS INTEGER) AS quantity,
        cast(subscription_id AS VARCHAR) AS subscription_id,
        cast(unit_amount AS FLOAT) AS unit_amount,
        cast(is_most_recent_record AS BOOLEAN) AS is_most_recent_record
    FROM
        {{ source('source_recurly', 'add_ons') }}
)
SELECT * FROM tmp
WHERE subscription_add_on_id IS NOT NULL