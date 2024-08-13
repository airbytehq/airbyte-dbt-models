{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            NULL AS coupon_redemption_id,
            NULL AS invoice_id,
            NULL AS invoice_updated_at,
            NULL AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE coupon_redemption_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            NULL AS coupon_redemption_id,
            NULL AS invoice_id,
            NULL AS invoice_updated_at,
            NULL AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE coupon_redemption_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            NULL AS coupon_redemption_id,
            NULL AS invoice_id,
            NULL AS invoice_updated_at,
            NULL AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE coupon_redemption_id IS NOT NULL

{% endif %}
