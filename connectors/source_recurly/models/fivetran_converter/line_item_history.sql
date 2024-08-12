{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS line_item_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            NULL AS account_id, 
            NULL AS add_on_code, 
            add_on_id,
            cast(total AS {{ dbt.type_float() }}) AS amount,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            NULL AS credit_applied, 
            NULL AS currency, 
            description,
            discount,
            NULL AS ended_at, 
            NULL AS has_refund, 
            invoice_id,
            NULL AS invoice_number, 
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            NULL AS is_taxable, 
            NULL AS original_line_item_invoice_id, 
            NULL AS origin, 
            NULL AS plan_code, 
            plan_id,
            NULL AS previous_line_item_id, 
            product_code,
            NULL AS proration_rate, 
            quantity,
            NULL AS refunded_quantity, 
            NULL AS started_at, 
            state,
            subscription_id,
            subtotal,
            tax,
            NULL AS tax_code, 
            NULL AS tax_exempt, 
            NULL AS tax_region, 
            NULL AS tax_rate, 
            NULL AS tax_type, 
            NULL AS type, 
            cast(unit_amount AS {{ dbt.type_float() }}) AS unit_amount,
            id AS uuid -- Using 'id' as 'uuid' since there's no separate 'uuid' field
        FROM
            {{ source('source_recurly', 'line_items') }}
    )
    SELECT * FROM tmp
    WHERE line_item_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS line_item_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            NULL AS account_id,
            NULL AS add_on_code,
            add_on_id,
            cast(total AS {{ dbt.type_float() }}) AS amount,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            NULL AS credit_applied,
            NULL AS currency,
            description,
            discount,
            NULL AS ended_at,
            NULL AS has_refund,
            invoice_id,
            NULL AS invoice_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            NULL AS is_taxable,
            NULL AS original_line_item_invoice_id,
            NULL AS origin,
            NULL AS plan_code,
            plan_id,
            NULL AS previous_line_item_id,
            product_code,
            NULL AS proration_rate,
            quantity,
            NULL AS refunded_quantity,
            NULL AS started_at,
            state,
            subscription_id,
            subtotal,
            tax,
            NULL AS tax_code,
            NULL AS tax_exempt,
            NULL AS tax_region,
            NULL AS tax_rate,
            NULL AS tax_type,
            NULL AS type,
            cast(unit_amount AS {{ dbt.type_float() }}) AS unit_amount,
            id AS uuid
        FROM
            {{ source('source_recurly', 'line_items') }}
    )
    SELECT * FROM tmp
    WHERE line_item_id IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS line_item_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            NULL AS account_id,
            NULL AS add_on_code,
            add_on_id,
            cast(total AS {{ dbt.type_float() }}) AS amount,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            NULL AS credit_applied,
            NULL AS currency,
            description,
            discount,
            NULL AS ended_at,
            NULL AS has_refund,
            invoice_id,
            NULL AS invoice_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            NULL AS is_taxable,
            NULL AS original_line_item_invoice_id,
            NULL AS origin,
            NULL AS plan_code,
            plan_id,
            NULL AS previous_line_item_id,
            product_code,
            NULL AS proration_rate,
            quantity,
            NULL AS refunded_quantity,
            NULL AS started_at,
            state,
            subscription_id,
            subtotal,
            tax,
            NULL AS tax_code,
            NULL AS tax_exempt,
            NULL AS tax_region,
            NULL AS tax_rate,
            NULL AS tax_type,
            NULL AS type,
            cast(unit_amount AS {{ dbt.type_float() }}) AS unit_amount,
            id AS uuid
        FROM
            {{ source('source_recurly', 'line_items') }}
    )
    SELECT * FROM tmp
    WHERE line_item_id IS NOT NULL

{% endif %}
