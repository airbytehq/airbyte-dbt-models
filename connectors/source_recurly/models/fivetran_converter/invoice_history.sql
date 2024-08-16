{% set column_names = adapter.get_columns_in_relation(source('source_recurly', 'invoices')) | map(attribute='name') | list %}

{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS invoice_id,
            CAST(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            CAST(NULL AS {{ dbt.type_float() }}) AS balance,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS closed_at,
            collection_method,
            CAST(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            CAST(discount AS {{ dbt.type_float() }}) AS discount,
            CAST(due_at AS {{ dbt.type_timestamp() }}) AS due_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            CAST(net_terms AS {{ dbt.type_int() }}) AS net_terms,
            invoice_number AS number,
            CAST(NULL AS VARCHAR) AS origin,
            CAST(NULL AS {{ dbt.type_float() }}) AS paid,
            po_number,
            CAST(NULL AS VARCHAR) AS previous_invoice_id,
            CAST(NULL AS {{ dbt.type_float() }}) AS refundable_amount,
            state,
            CAST(subtotal AS {{ dbt.type_float() }}) AS subtotal,
            CAST(tax AS {{ dbt.type_float() }}) AS tax,
            CAST(NULL AS {{ dbt.type_float() }}) AS tax_rate,
            CAST(NULL AS VARCHAR) AS tax_region,
            CAST(NULL AS VARCHAR) AS tax_type,
            CAST(total AS {{ dbt.type_float() }}) AS total,
            CAST('invoice' AS VARCHAR) AS type
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS invoice_id,
            CAST(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            CAST(NULL AS {{ dbt.type_float() }}) AS balance,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS closed_at,
            collection_method,
            CAST(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            CAST(discount AS {{ dbt.type_float() }}) AS discount,
            CAST(due_at AS {{ dbt.type_timestamp() }}) AS due_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            CAST(net_terms AS {{ dbt.type_int() }}) AS net_terms,
            invoice_number AS number,
            CAST(NULL AS STRING) AS origin,
            CAST(NULL AS {{ dbt.type_float() }}) AS paid,
            po_number,
            CAST(NULL AS STRING) AS previous_invoice_id,
            CAST(NULL AS {{ dbt.type_float() }}) AS refundable_amount,
            state,
            CAST(subtotal AS {{ dbt.type_float() }}) AS subtotal,
            CAST(tax AS {{ dbt.type_float() }}) AS tax,
            CAST(NULL AS {{ dbt.type_float() }}) AS tax_rate,
            CAST(NULL AS STRING) AS tax_region,
            CAST(NULL AS STRING) AS tax_type,
            CAST(total AS {{ dbt.type_float() }}) AS total,
            CAST('invoice' AS STRING) AS type
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS invoice_id,
            CAST(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            CAST(NULL AS {{ dbt.type_float() }}) AS balance,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS closed_at,
            collection_method,
            CAST(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            CAST(discount AS {{ dbt.type_float() }}) AS discount,
            CAST(due_at AS {{ dbt.type_timestamp() }}) AS due_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            CAST(net_terms AS {{ dbt.type_int() }}) AS net_terms,
            invoice_number AS number,
            CAST(NULL AS STRING) AS origin,
            CAST(NULL AS {{ dbt.type_float() }}) AS paid,
            po_number,
            CAST(NULL AS STRING) AS previous_invoice_id,
            CAST(NULL AS {{ dbt.type_float() }}) AS refundable_amount,
            state,
            CAST(subtotal AS {{ dbt.type_float() }}) AS subtotal,
            CAST(tax AS {{ dbt.type_float() }}) AS tax,
            CAST(NULL AS {{ dbt.type_float() }}) AS tax_rate,
            CAST(NULL AS STRING) AS tax_region,
            CAST(NULL AS STRING) AS tax_type,
            CAST(total AS {{ dbt.type_float() }}) AS total,
            CAST('invoice' AS STRING) AS type
        FROM
            {{ source('source_recurly', 'invoices') }}
    )
    SELECT * FROM tmp
    WHERE invoice_id IS NOT NULL

{% endif %}