{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS credit_payment_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account->>id AS account_id,
            action,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            (applied_to_invoice->>'id')::text AS applied_to_invoice_id,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            (refund_transaction->>'id')::text AS refund_transaction_id,
            (original_credit_payment_id)::text AS original_credit_payment_id,
            (original_invoice->>'id')::text AS original_invoice_id,
            id AS uuid,
            cast(voided_at AS {{ dbt.type_timestamp() }}) AS voided_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'credit_payments') }}
    )
    SELECT * FROM tmp
    WHERE credit_payment_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS credit_payment_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account:id AS account_id,
            action,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            applied_to_invoice:id::text AS applied_to_invoice_id,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            refund_transaction:id::text AS refund_transaction_id,
            original_credit_payment_id::text AS original_credit_payment_id,
            original_invoice:id::text AS original_invoice_id,
            id AS uuid,
            cast(voided_at AS {{ dbt.type_timestamp() }}) AS voided_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'credit_payments') }}
    )
    SELECT * FROM tmp
    WHERE credit_payment_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS credit_payment_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            JSON_EXTRACT_SCALAR(account, '$.id') AS account_id,
            action,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            JSON_EXTRACT_SCALAR(applied_to_invoice, '$.id') AS applied_to_invoice_id,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            JSON_EXTRACT_SCALAR(refund_transaction, '$.id') AS refund_transaction_id,
            original_credit_payment_id AS original_credit_payment_id,
            JSON_EXTRACT_SCALAR(original_invoice, '$.id') AS original_invoice_id,
            id AS uuid,
            cast(voided_at AS {{ dbt.type_timestamp() }}) AS voided_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'credit_payments') }}
    )
    SELECT * FROM tmp
    WHERE credit_payment_id IS NOT NULL

{% endif %}
