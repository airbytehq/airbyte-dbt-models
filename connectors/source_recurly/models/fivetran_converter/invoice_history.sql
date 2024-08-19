{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS invoice_id,
            cast(updated_at AS TIMESTAMP) AS updated_at,
            account->>id AS account_id,
            cast(balance AS FLOAT) AS balance,
            cast(NULL AS TIMESTAMP) AS closed_at,
            collection_method,
            cast(created_at AS TIMESTAMP) AS created_at,
            currency,
            cast(discount AS FLOAT) AS discount,
            cast(due_at AS TIMESTAMP) AS due_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            cast(net_terms AS INTEGER) AS net_terms,
            invoice_number AS number,
            cast(origin AS VARCHAR) AS origin,
            cast(paid AS FLOAT) AS paid,
            po_number,
            cast(previous_invoice_id AS VARCHAR) AS previous_invoice_id,
            cast(refundable_amount AS FLOAT) AS refundable_amount,
            state,
            cast(subtotal AS FLOAT) AS subtotal,
            cast(tax AS FLOAT) AS tax,
            tax_info->>'rate' AS tax_rate,
            tax_info->>'region' AS tax_region,
            tax_info->>'type' AS tax_type,
            type,
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
            cast(balance AS FLOAT) AS balance,
            cast(NULL AS TIMESTAMP) AS closed_at,
            collection_method,
            cast(created_at AS TIMESTAMP) AS created_at,
            currency,
            cast(discount AS FLOAT) AS discount,
            cast(due_at AS TIMESTAMP) AS due_at,
            CASE WHEN ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 THEN TRUE ELSE FALSE END AS is_most_recent_record,
            cast(net_terms AS INTEGER) AS net_terms,
            invoice_number AS number,
            cast(origin AS STRING) AS origin,
            cast(paid AS FLOAT) AS paid,
            po_number,
            cast(previous_invoice_id AS STRING) AS previous_invoice_id,
            cast(refundable_amount AS FLOAT) AS refundable_amount,
            state,
            cast(subtotal AS FLOAT) AS subtotal,
            cast(tax AS FLOAT) AS tax,
            tax_info:rate AS tax_rate,
            tax_info:region AS tax_region,
            tax_info:type AS tax_type,
            type,
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
            cast(balance AS FLOAT) AS balance,
            cast(NULL AS TIMESTAMP) AS closed_at,
            collection_method,
            cast(created_at AS TIMESTAMP) AS created_at,
            currency,
            cast(discount AS FLOAT64) AS discount,
            cast(due_at AS TIMESTAMP) AS due_at,
            IF(ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1, TRUE, FALSE) AS is_most_recent_record,
            cast(net_terms AS INT64) AS net_terms,
            invoice_number AS number,
            cast(origin AS STRING) AS origin,
            cast(paid AS FLOAT64) AS paid,
            po_number,
            cast(previous_invoice_id AS STRING) AS previous_invoice_id,
            cast(refundable_amount AS FLOAT64) AS refundable_amount,
            state,
            cast(subtotal AS FLOAT64) AS subtotal,
            cast(tax AS FLOAT64) AS tax,
            JSON_EXTRACT_SCALAR(tax_info, '$.rate') AS tax_rate,
            JSON_EXTRACT_SCALAR(tax_info, '$.region') AS tax_region,
            JSON_EXTRACT_SCALAR(tax_info, '$.type') AS tax_type,
            type,
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% endif %}
