WITH tmp AS (
    SELECT
        NULL AS coupon_redemption_id,
        id AS invoice_id,
        updated_at AS invoice_updated_at,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_recurly', 'invoices') }}
)
SELECT * FROM tmp
WHERE coupon_redemption_id IS NOT NULL
