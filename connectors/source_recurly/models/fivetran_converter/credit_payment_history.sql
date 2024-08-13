{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS credit_payment_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            NULL AS account_id,
            NULL AS action,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            invoice_id AS applied_to_invoice_id,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            NULL AS refund_transaction_id,
            NULL AS original_credit_payment_id,
            NULL AS original_invoice_id,
            id AS uuid,
            NULL AS voided_at,
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
            NULL AS account_id,
            NULL AS action,  
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            invoice_id AS applied_to_invoice_id,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            NULL AS refund_transaction_id,  
            NULL AS original_credit_payment_id,  
            NULL AS original_invoice_id,  
            id AS uuid,  -- Using 'id' as 'uuid' since there's no separate 'uuid' field
            NULL AS voided_at,  
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
            NULL AS account_id,
            NULL AS action,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            invoice_id AS applied_to_invoice_id,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            NULL AS refund_transaction_id,
            NULL AS original_credit_payment_id,
            NULL AS original_invoice_id,
            id AS uuid,
            NULL AS voided_at,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'credit_payments') }}
    )
    SELECT * FROM tmp
    WHERE credit_payment_id IS NOT NULL

{% endif %}
