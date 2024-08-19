{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS invoice_id,
            cast(updated_at AS TIMESTAMP) AS updated_at,
            account->>id AS account_id,
            balance,
            cast(NULL AS TIMESTAMP) AS closed_at,
            collection_method,
            cast(created_at AS TIMESTAMP) AS created_at,
            currency,
            discount,
            cast(due_at AS TIMESTAMP) AS due_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            cast(net_terms AS INTEGER) AS net_terms,
            number,
            cast(origin AS VARCHAR) AS origin,
            paid,
            po_number,
            cast(previous_invoice_id AS VARCHAR) AS previous_invoice_id,
            refundable_amount,
            state,
            subtotal,
            tax,
            tax_info->>'rate' AS tax_rate,
            tax_info->>'region' AS tax_region,
            tax_info->>'type' AS tax_type,
            type
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS invoice_id,
            cast(updated_at AS TIMESTAMP) AS updated_at,
            account:id AS account_id,
            balance,
            cast(NULL AS TIMESTAMP) AS closed_at,
            collection_method,
            cast(created_at AS TIMESTAMP) AS created_at,
            currency,
            discount,
            cast(due_at AS TIMESTAMP) AS due_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            cast(net_terms AS INTEGER) AS net_terms,
            number,
            cast(origin AS STRING) AS origin,
            paid,
            po_number,
            cast(previous_invoice_id AS STRING) AS previous_invoice_id,
            refundable_amount,
            state,
            subtotal,
            tax,
            tax_info:rate AS tax_rate,
            tax_info:region AS tax_region,
            tax_info:type AS tax_type,
            type
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS invoice_id,
            cast(updated_at AS TIMESTAMP) AS updated_at,
            JSON_EXTRACT_SCALAR(account, '$.id') AS account_id,
            balance,
            cast(NULL AS TIMESTAMP) AS closed_at,
            collection_method,
            cast(created_at AS TIMESTAMP) AS created_at,
            currency,
            discount,
            cast(due_at AS TIMESTAMP) AS due_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            cast(net_terms AS INTEGER) AS net_terms,
            number,
            cast(origin AS STRING) AS origin,
            paid,
            po_number,
            cast(previous_invoice_id AS STRING) AS previous_invoice_id,
            refundable_amount,
            state,
            subtotal,
            tax,
            JSON_EXTRACT_SCALAR(tax_info, '$.rate') AS tax_rate,
            JSON_EXTRACT_SCALAR(tax_info, '$.region') AS tax_region,
            JSON_EXTRACT_SCALAR(tax_info, '$.type') AS tax_type,
            type
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% endif %}
