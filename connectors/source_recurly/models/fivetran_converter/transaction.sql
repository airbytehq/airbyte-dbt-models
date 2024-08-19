{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS transaction_id,
            cast(collected_at AS {{ dbt.type_timestamp() }}) AS created_at,
            account->>'id' AS account_id,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            billing_address->>'city' AS billing_city,
            billing_address->>'country' AS billing_country,
            billing_address->>'first_name' AS billing_first_name,
            billing_address->>'last_name' AS billing_last_name,
            billing_address->>'phone' AS billing_phone,
            billing_address->>'postal_code' AS billing_postal_code,
            billing_address->>'region' AS billing_region,
            billing_address->>'street1' AS billing_street_1,
            billing_address->>'street2' AS billing_street_2,
            cast(collected_at AS {{ dbt.type_timestamp() }}) AS collected_at,
            collection_method,
            currency,
            customer_message,
            customer_message_locale,
            gateway_approval_code,
            gateway_message,
            gateway_reference,
            gateway_response_code,
            gateway_response_time,
            gateway_response_values,
            invoice->>'id' AS invoice_id,
            CASE WHEN status = 'refunded' THEN TRUE ELSE FALSE END AS is_refunded,
            CASE WHEN status = 'success' THEN TRUE ELSE FALSE END AS is_successful,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY collected_at DESC) = 1 AS is_most_recent_record,
            origin,
            original_transaction_id,
            payment_gateway->>'id' AS payment_gateway_id,
            payment_gateway->>'name' AS payment_gateway_name,
            payment_gateway->>'type' AS payment_gateway_type,
            payment_method AS payment_method_object,
            status,
            status_code,
            status_message,
            type,
            id AS uuid,
            cast(voided_at AS {{ dbt.type_timestamp() }}) AS voided_at,
            voided_by_invoice->>'id' AS voided_by_invoice_id
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
            account:id AS account_id,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            billing_address:city AS billing_city,
            billing_address:country AS billing_country,
            billing_address:first_name AS billing_first_name,
            billing_address:last_name AS billing_last_name,
            billing_address:phone AS billing_phone,
            billing_address:postal_code AS billing_postal_code,
            billing_address:region AS billing_region,
            billing_address:street1 AS billing_street_1,
            billing_address:street2 AS billing_street_2,
            cast(collected_at AS {{ dbt.type_timestamp() }}) AS collected_at,
            collection_method,
            currency,
            customer_message,
            customer_message_locale,
            gateway_approval_code,
            gateway_message,
            gateway_reference,
            gateway_response_code,
            gateway_response_time,
            gateway_response_values,
            invoice:id AS invoice_id,
            CASE WHEN status = 'refunded' THEN TRUE ELSE FALSE END AS is_refunded,
            CASE WHEN status = 'success' THEN TRUE ELSE FALSE END AS is_successful,
            CASE WHEN ROW_NUMBER() OVER (PARTITION BY id ORDER BY collected_at DESC) = 1 THEN TRUE ELSE FALSE END AS is_most_recent_record,
            origin,
            original_transaction_id,
            payment_gateway:id AS payment_gateway_id,
            payment_gateway:name AS payment_gateway_name,
            payment_gateway:type AS payment_gateway_type,
            payment_method AS payment_method_object,
            status,
            status_code,
            status_message,
            type,
            id AS uuid,
            cast(voided_at AS {{ dbt.type_timestamp() }}) AS voided_at,
            voided_by_invoice:id AS voided_by_invoice_id
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
            JSON_EXTRACT_SCALAR(account, '$.id') AS account_id,
            cast(amount AS {{ dbt.type_float() }}) AS amount,
            JSON_EXTRACT_SCALAR(billing_address, '$.city') AS billing_city,
            JSON_EXTRACT_SCALAR(billing_address, '$.country') AS billing_country,
            JSON_EXTRACT_SCALAR(billing_address, '$.first_name') AS billing_first_name,
            JSON_EXTRACT_SCALAR(billing_address, '$.last_name') AS billing_last_name,
            JSON_EXTRACT_SCALAR(billing_address, '$.phone') AS billing_phone,
            JSON_EXTRACT_SCALAR(billing_address, '$.postal_code') AS billing_postal_code,
            JSON_EXTRACT_SCALAR(billing_address, '$.region') AS billing_region,
            JSON_EXTRACT_SCALAR(billing_address, '$.street1') AS billing_street_1,
            JSON_EXTRACT_SCALAR(billing_address, '$.street2') AS billing_street_2,
            cast(collected_at AS {{ dbt.type_timestamp() }}) AS collected_at,
            collection_method,
            currency,
            customer_message,
            customer_message_locale,
            gateway_approval_code,
            gateway_message,
            gateway_reference,
            gateway_response_code,
            gateway_response_time,
            gateway_response_values,
            JSON_EXTRACT_SCALAR(invoice, '$.id') AS invoice_id,
            IF(status = 'refunded', TRUE, FALSE) AS is_refunded,
            IF(status = 'success', TRUE, FALSE) AS is_successful,
            IF(ROW_NUMBER() OVER (PARTITION BY id ORDER BY collected_at DESC) = 1, TRUE, FALSE) AS is_most_recent_record,
            origin,
            original_transaction_id,
            JSON_EXTRACT_SCALAR(payment_gateway, '$.id') AS payment_gateway_id,
            JSON_EXTRACT_SCALAR(payment_gateway, '$.name') AS payment_gateway_name,
            JSON_EXTRACT_SCALAR(payment_gateway, '$.type') AS payment_gateway_type,
            payment_method AS payment_method_object,
            status,
            status_code,
            status_message,
            type,
            id AS uuid,
            cast(voided_at AS {{ dbt.type_timestamp() }}) AS voided_at,
            JSON_EXTRACT_SCALAR(voided_by_invoice, '$.id') AS voided_by_invoice_id
        FROM
            {{ source('source_recurly', 'transactions') }}
    )
    SELECT * FROM tmp
    WHERE transaction_id IS NOT NULL

{% endif %}
