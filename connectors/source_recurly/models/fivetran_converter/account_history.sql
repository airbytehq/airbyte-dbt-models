{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS account_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            address->>'city' AS account_city,
            address->>'country' AS account_country,
            address->>'postal_code' AS account_postal_code,
            address->>'region' AS account_region,
            bill_to,
            cc_emails,
            code,
            company,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            cast(deleted_at AS {{ dbt.type_timestamp() }}) AS deleted_at,
            email,
            first_name,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            tax_exempt AS is_tax_exempt,
            last_name,
            state,
            username,
            vat_number
        FROM
            {{ source('source_recurly', 'accounts') }}
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS account_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            address:"city"::string AS account_city,
            address:"country"::string AS account_country,
            address:"postal_code"::string AS account_postal_code,
            address:"region"::string AS account_region,
            bill_to,
            cc_emails,
            code,
            company,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            cast(deleted_at AS {{ dbt.type_timestamp() }}) AS deleted_at,
            email,
            first_name,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            tax_exempt AS is_tax_exempt,
            last_name,
            state,
            username,
            vat_number
        FROM
            {{ source('source_recurly', 'accounts') }}
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS account_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            JSON_EXTRACT_SCALAR(address, '$.city') AS account_city,
            JSON_EXTRACT_SCALAR(address, '$.country') AS account_country,
            JSON_EXTRACT_SCALAR(address, '$.postal_code') AS account_postal_code,
            JSON_EXTRACT_SCALAR(address, '$.region') AS account_region,
            bill_to,
            cc_emails,
            code,
            company,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            cast(deleted_at AS {{ dbt.type_timestamp() }}) AS deleted_at,
            email,
            first_name,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            tax_exempt AS is_tax_exempt,
            last_name,
            state,
            username,
            vat_number
        FROM
            {{ source('source_recurly', 'accounts') }}
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% endif %}
