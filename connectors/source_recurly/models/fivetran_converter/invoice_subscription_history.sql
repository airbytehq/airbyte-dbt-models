WITH tmp AS (
    SELECT
        id AS invoice_id,
        cast(updated_at AS TIMESTAMP) AS invoice_updated_at,
        cast(subscription_ids[0]) AS subscription_id,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY invoice_updated_at DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_recurly', 'invoices') }}
)
SELECT * FROM tmp
WHERE invoice_id IS NOT NULL
