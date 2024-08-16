
{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            NULL AS invoice_id,
            NULL AS invoice_updated_at,
            NULL AS subscription_id,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY invoice_updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            NULL AS invoice_id,
            NULL AS invoice_updated_at,
            NULL AS subscription_id,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY invoice_updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            NULL AS invoice_id,
            NULL AS invoice_updated_at,
            NULL AS subscription_id,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY invoice_updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% endif %}
