{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS line_item_id,
            updated_at,
            account->>id AS account_id,
            add_on_code,
            add_on_id,
            amount,
            created_at,
            credit_applied,
            currency,
            description,
            discount,
            end_date AS ended_at,
            refund AS has_refund,
            invoice_id,
            invoice_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            taxable AS is_taxable,
            original_line_item_invoice_id,
            origin,
            plan_code,
            plan_id,
            previous_line_item_id AS previous_line_item_id,
            product_code,
            proration_rate,
            quantity,
            refunded_quantity,
            start_date AS started_at,
            state,
            subscription_id,
            subtotal,
            tax,
            tax_code,
            tax_exempt,
            tax_info->>'region' AS tax_region,
            tax_info->>'rate' AS tax_rate,
            tax_info->>'type' AS tax_type,
            type,
            unit_amount,
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
            updated_at,
            account:id AS account_id,
            add_on_code,
            add_on_id,
            amount,
            created_at,
            credit_applied,
            currency,
            description,
            discount,
            end_date AS ended_at,
            refund AS has_refund,
            invoice_id,
            invoice_number,
            CASE WHEN ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 THEN TRUE ELSE FALSE END AS is_most_recent_record,
            taxable AS is_taxable,
            original_line_item_invoice_id,
            origin,
            plan_code,
            plan_id,
            previous_line_item_id,
            product_code,
            proration_rate,
            quantity,
            refunded_quantity,
            start_date AS started_at,
            state,
            subscription_id,
            subtotal,
            tax,
            tax_code,
            tax_exempt,
            tax_info:region AS tax_region,
            tax_info:rate AS tax_rate,
            tax_info:type AS tax_type,
            type,
            unit_amount,
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
            updated_at,
            JSON_EXTRACT_SCALAR(account, '$.id') AS account_id,
            add_on_code,
            add_on_id,
            amount,
            created_at,
            credit_applied,
            currency,
            description,
            discount,
            end_date AS ended_at,
            refund AS has_refund,
            invoice_id,
            invoice_number,
            IF(ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1, TRUE, FALSE) AS is_most_recent_record,
            taxable AS is_taxable,
            original_line_item_invoice_id,
            origin,
            plan_code,
            plan_id,
            previous_line_item_id,
            product_code,
            proration_rate,
            quantity,
            refunded_quantity,
            start_date AS started_at,
            state,
            subscription_id,
            subtotal,
            tax,
            tax_code,
            tax_exempt,
            JSON_EXTRACT_SCALAR(tax_info, '$.region') AS tax_region,
            JSON_EXTRACT_SCALAR(tax_info, '$.rate') AS tax_rate,
            JSON_EXTRACT_SCALAR(tax_info, '$.type') AS tax_type,
            type,
            unit_amount,
            id AS uuid
        FROM
            {{ source('source_recurly', 'line_items') }}
    )
    SELECT * FROM tmp
    WHERE line_item_id IS NOT NULL

{% endif %}
