
{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS invoice_id,
            NULL AS updated_at,
            NULL AS account_id,
            NULL AS balance,
            NULL AS closed_at,
            NULL AS collection_method,
            NULL AS created_at,
            NULL AS currency,
            NULL AS discount,
            NULL AS due_at,
            NULL AS is_most_recent_record,
            NULL AS net_terms,
            NULL AS number,
            NULL AS origin,
            NULL AS paid,
            NULL AS po_number,        
            NULL AS previous_invoice_id,
            NULL AS refundable_amount,
            NULL AS state,
            NULL AS subtotal,
            NULL AS tax,
            NULL AS tax_rate,
            NULL AS tax_region,
            NULL AS tax_type,
            NULL AS total,
            NULL AS type
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            NULL AS invoice_id,
            NULL AS updated_at,
            NULL AS account_id,
            NULL AS balance,
            NULL AS closed_at,
            NULL AS collection_method,
            NULL AS created_at,
            NULL AS currency,
            NULL AS discount,
            NULL AS due_at,
            NULL AS is_most_recent_record,
            NULL AS net_terms,
            NULL AS number,
            NULL AS origin,
            NULL AS paid,
            NULL AS po_number,        
            NULL AS previous_invoice_id,
            NULL AS refundable_amount,
            NULL AS state,
            NULL AS subtotal,
            NULL AS tax,
            NULL AS tax_rate,
            NULL AS tax_region,
            NULL AS tax_type,
            NULL AS total,
            NULL AS type
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            NULL AS invoice_id,
            NULL AS updated_at,
            NULL AS account_id,
            NULL AS balance,
            NULL AS closed_at,
            NULL AS collection_method,
            NULL AS created_at,
            NULL AS currency,
            NULL AS discount,
            NULL AS due_at,
            NULL AS is_most_recent_record,
            NULL AS net_terms,
            NULL AS number,
            NULL AS origin,
            NULL AS paid,
            NULL AS po_number,        
            NULL AS previous_invoice_id,
            NULL AS refundable_amount,
            NULL AS state,
            NULL AS subtotal,
            NULL AS tax,
            NULL AS tax_rate,
            NULL AS tax_region,
            NULL AS tax_type,
            NULL AS total,
            NULL AS type
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% endif %}
