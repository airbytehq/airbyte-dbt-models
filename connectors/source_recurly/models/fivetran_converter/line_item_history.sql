{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS line_item_id,
            cast(updated_at AS TIMESTAMP) AS updated_at,
            account->>id AS account_id,
            add_on_code,
            add_on_id,
            amount,
            cast(created_at AS TIMESTAMP) AS created_at,
            credit_applied,
            currency,
            description,
            discount,
            end_date AS TIMESTAMP AS ended_at,
            refund AS has_refund,
            invoices->>id as invoice_id,
            invoices->>invoice_number as invoice_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            taxable AS is_taxable,
            original_line_item_invoice_id,
            origin,
            plan_code AS plan_code,
            plan_id,
            previous_line_item_id AS previous_line_item_id,
            product_code,
            proration_rate,
            quantity,
            refunded_quantity,
            start_date AS TIMESTAMP AS started_at,
            state,
            subscription_id,
            invoices->>subtotal AS subtotal,
            tax,
            tax_code,
            tax_exempt,
            tax_info->>'region' AS tax_region,
            tax_info->>'rate' AS tax_rate,
            tax_info->>'type' AS tax_type,
            type,
            cast(unit_amount AS FLOAT) AS unit_amount,
            id AS uuid
        FROM
            {{ source('source_recurly', 'line_items') }}
    )
    SELECT * FROM tmp
    WHERE line_item_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS line_item_id,
            cast(updated_at AS TIMESTAMP) AS updated_at,
            account:id AS account_id,
            add_on_code,
            add_on_id,
            amount,
            cast(created_at AS TIMESTAMP) AS created_at,
            credit_applied,
            currency,
            description,
            discount,
            end_date AS TIMESTAMP AS ended_at,
            refund AS has_refund,
            invoice_id,
            invoice_number,
            CASE WHEN ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 THEN TRUE ELSE FALSE END AS is_most_recent_record,
            taxable AS is_taxable,
            original_line_item_invoice_id,
            origin,
            plan_code AS plan_code,
            plan_id,
            previous_line_item_id AS previous_line_item_id,
            product_code,
            proration_rate,
            quantity,
            refunded_quantity,
            start_date AS TIMESTAMP AS started_at,
            state,
            subscription_id,
            invoices:subtotal AS subtotal,
            tax,
            tax_code,
            tax_exempt,
            tax_info:region AS tax_region,
            tax_info:rate AS tax_rate,
            tax_info:type AS tax_type,
            type,
            cast(unit_amount AS FLOAT) AS unit_amount,
            id AS uuid
        FROM
            {{ source('source_recurly', 'line_items') }}
    )
    SELECT * FROM tmp
    WHERE line_item_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS line_item_id,
            cast(updated_at AS TIMESTAMP) AS updated_at,
            JSON_EXTRACT_SCALAR(account, '$.id') AS account_id,
            add_on_code,
            add_on_id,
            amount,
            cast(created_at AS TIMESTAMP) AS created_at,
            credit_applied,
            currency,
            description,
            discount,
            cast(end_date AS TIMESTAMP) AS ended_at,
            refund AS has_refund,
            invoice_id,
            invoice_number,
            IF(ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1, TRUE, FALSE) AS is_most_recent_record,
            taxable AS is_taxable,
            original_line_item_invoice_id,
            origin,
            plan_code AS plan_code,
            plan_id,
            previous_line_item_id AS previous_line_item_id,
            product_code,
            proration_rate,
            quantity,
            refunded_quantity,
            cast(start_date AS TIMESTAMP) AS started_at,
            state,
            subscription_id,
            JSON_EXTRACT_SCALAR(invoices, '$.subtotal') AS subtotal,
            tax,
            tax_code,
            tax_exempt,
            JSON_EXTRACT_SCALAR(tax_info, '$.region') AS tax_region,
            JSON_EXTRACT_SCALAR(tax_info, '$.rate') AS tax_rate,
            JSON_EXTRACT_SCALAR(tax_info, '$.type') AS tax_type,
            type,
            cast(unit_amount AS FLOAT64) AS unit_amount,
            id AS uuid
        FROM
            {{ source('source_recurly', 'line_items') }}
    )
    SELECT * FROM tmp
    WHERE line_item_id IS NOT NULL

{% endif %}
