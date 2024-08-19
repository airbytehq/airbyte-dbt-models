WITH tmp AS (
    SELECT
        NULL AS transaction_id,
        NULL AS subscription_id
    FROM
        {{ source('source_recurly', 'transactions') }}
)
SELECT * FROM tmp
WHERE transaction_id IS NOT NULL
