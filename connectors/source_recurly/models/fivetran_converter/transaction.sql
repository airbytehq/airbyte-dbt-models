{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS transaction_id,
            cast(collected_at AS {{ dbt.type_timestamp() }}) AS created_at,
            NULL AS account_id,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            NULL AS billing_city,
            NULL AS billing_country,
            NULL AS billing_first_name,
            NULL AS billing_last_name,
            NULL AS billing_phone,
            NULL AS billing_postal_code,
            NULL AS billing_region,
            NULL AS billing_street_1,
            NULL AS billing_street_2,
            cast(collected_at AS {{ dbt.type_timestamp() }}) AS collected_at,
            NULL AS collection_method,
            currency,
            NULL AS customer_message,
            NULL AS customer_message_locale,
            NULL AS gateway_approval_code,
            NULL AS gateway_message,
            NULL AS gateway_reference,
            NULL AS gateway_response_code,
            NULL AS gateway_response_time,
            NULL AS gateway_response_values,
            invoice_id,
            CASE WHEN status = 'refunded' THEN TRUE ELSE FALSE END AS is_refunded,
            CASE WHEN status = 'success' THEN TRUE ELSE FALSE END AS is_successful,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY collected_at DESC) = 1 AS is_most_recent_record,
            origin,
            NULL AS original_transaction_id,
            gateway_id AS payment_gateway_id,
            gateway AS payment_gateway_name,
            NULL AS payment_gateway_type,
            payment_method AS payment_method_object,
            status,
            NULL AS status_code,
            NULL AS status_message,
            type,
            id AS uuid,
            cast(voided_at AS {{ dbt.type_timestamp() }}) AS voided_at,
            NULL AS voided_by_invoice_id
        FROM
            {{ source('source_recurly', 'transactions') }}
    )
    SELECT * FROM tmp
    WHERE transaction_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS transaction_id,
            cast(collected_at AS {{ dbt.type_timestamp() }}) AS created_at,
            NULL AS account_id,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            NULL AS billing_city,
            NULL AS billing_country,
            NULL AS billing_first_name,
            NULL AS billing_last_name,
            NULL AS billing_phone,
            NULL AS billing_postal_code,
            NULL AS billing_region,
            NULL AS billing_street_1,
            NULL AS billing_street_2,
            cast(collected_at AS {{ dbt.type_timestamp() }}) AS collected_at,
            NULL AS collection_method,
            currency,
            NULL AS customer_message,
            NULL AS customer_message_locale,
            NULL AS gateway_approval_code,
            NULL AS gateway_message,
            NULL AS gateway_reference,
            NULL AS gateway_response_code,
            NULL AS gateway_response_time,
            NULL AS gateway_response_values,
            invoice_id,
            CASE WHEN status = 'refunded' THEN TRUE ELSE FALSE END AS is_refunded,
            CASE WHEN status = 'success' THEN TRUE ELSE FALSE END AS is_successful,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY collected_at DESC) = 1 AS is_most_recent_record,
            origin,
            NULL AS original_transaction_id,
            gateway_id AS payment_gateway_id,
            gateway AS payment_gateway_name,
            NULL AS payment_gateway_type,
            payment_method AS payment_method_object,
            status,
            NULL AS status_code,
            NULL AS status_message,
            type,
            id AS uuid,
            cast(voided_at AS {{ dbt.type_timestamp() }}) AS voided_at,
            NULL AS voided_by_invoice_id
        FROM
            {{ source('source_recurly', 'transactions') }}
    )
    SELECT * FROM tmp
    WHERE transaction_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS transaction_id,
            cast(collected_at AS {{ dbt.type_timestamp() }}) AS created_at,
            NULL AS account_id,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            NULL AS billing_city,
            NULL AS billing_country,
            NULL AS billing_first_name,
            NULL AS billing_last_name,
            NULL AS billing_phone,
            NULL AS billing_postal_code,
            NULL AS billing_region,
            NULL AS billing_street_1,
            NULL AS billing_street_2,
            cast(collected_at AS {{ dbt.type_timestamp() }}) AS collected_at,
            NULL AS collection_method,
            currency,
            NULL AS customer_message,
            NULL AS customer_message_locale,
            NULL AS gateway_approval_code,
            NULL AS gateway_message,
            NULL AS gateway_reference,
            NULL AS gateway_response_code,
            NULL AS gateway_response_time,
            NULL AS gateway_response_values,
            invoice_id,
            CASE WHEN status = 'refunded' THEN TRUE ELSE FALSE END AS is_refunded,
            CASE WHEN status = 'success' THEN TRUE ELSE FALSE END AS is_successful,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY collected_at DESC) = 1 AS is_most_recent_record,
            origin,
            NULL AS original_transaction_id,
            gateway_id AS payment_gateway_id,
            gateway AS payment_gateway_name,
            NULL AS payment_gateway_type,
            payment_method AS payment_method_object,
            status,
            NULL AS status_code,
            NULL AS status_message,
            type,
            id AS uuid,
            cast(voided_at AS {{ dbt.type_timestamp() }}) AS voided_at,
            NULL AS voided_by_invoice_id
        FROM
            {{ source('source_recurly', 'transactions') }}
    )
    SELECT * FROM tmp
    WHERE transaction_id IS NOT NULL

{% endif %}