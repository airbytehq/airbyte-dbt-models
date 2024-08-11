{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            t.id AS account_id,
            t.updated_at AS updated_at,
            t.address:city::STRING AS account_city,
            t.address:country::STRING AS account_country,
            t.address:postal_code::STRING AS account_postal_code,
            t.address:region::STRING AS account_region,
            t.bill_to AS bill_to,
            t.cc_emails AS cc_emails,
            t.code AS code,
            t.shipping_addresses[0]:company::STRING AS company,
            t.created_at AS created_at,
            t.deleted_at AS deleted_at,
            t.shipping_addresses[0]:email::STRING AS email,
            t.shipping_addresses[0]:first_name::STRING AS first_name,
            ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY t.updated_at DESC) = 1 AS is_most_recent_record,
            t.tax_exempt AS is_tax_exempt,
            t.shipping_addresses[0]:last_name::STRING AS last_name,
            t.address:region::STRING AS state,
            t.username AS username,
            t.shipping_addresses[0]:vat_number::STRING AS vat_number
        FROM
            {{ source('source_recurly', 'accounts') }} t
    )
    SELECT * FROM tmp
    WHERE field_name IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            t.id AS account_id,
            t.updated_at AS updated_at,
            JSON_EXTRACT_SCALAR(t.address, '$.city') AS account_city,
            JSON_EXTRACT_SCALAR(t.address, '$.country') AS account_country,
            JSON_EXTRACT_SCALAR(t.address, '$.postal_code') AS account_postal_code,
            JSON_EXTRACT_SCALAR(t.address, '$.region') AS account_region,
            t.bill_to AS bill_to,
            t.cc_emails AS cc_emails,
            t.code AS code,
            JSON_EXTRACT_SCALAR(t.shipping_addresses[OFFSET(0)], '$.company') AS company,
            t.created_at AS created_at,
            t.deleted_at AS deleted_at,
            JSON_EXTRACT_SCALAR(t.shipping_addresses[OFFSET(0)], '$.email') AS email,
            JSON_EXTRACT_SCALAR(t.shipping_addresses[OFFSET(0)], '$.first_name') AS first_name,
            ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY t.updated_at DESC) = 1 AS is_most_recent_record,
            t.tax_exempt AS is_tax_exempt,
            JSON_EXTRACT_SCALAR(t.shipping_addresses[OFFSET(0)], '$.last_name') AS last_name,
            JSON_EXTRACT_SCALAR(t.address, '$.region') AS state,
            t.username AS username,
            JSON_EXTRACT_SCALAR(t.shipping_addresses[OFFSET(0)], '$.vat_number') AS vat_number
        FROM
            {{ source('source_recurly', 'accounts') }} t
    )
    SELECT * FROM tmp
    WHERE FIELD_NAME IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            t.id AS account_id,
            t.updated_at AS updated_at,
            t.address->>'city' AS account_city,
            t.address->>'country' AS account_country,
            t.address->>'postal_code' AS account_postal_code,
            t.address->>'region' AS account_region,
            t.bill_to AS bill_to,
            t.cc_emails AS cc_emails,
            t.code AS code,
            t.shipping_addresses->0->>'company' AS company,
            t.created_at AS created_at,
            t.deleted_at AS deleted_at,
            t.shipping_addresses->0->>'email' AS email,
            t.shipping_addresses->0->>'first_name' AS first_name,
            ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY t.updated_at DESC) = 1 AS is_most_recent_record,
            t.tax_exempt AS is_tax_exempt,
            t.shipping_addresses->0->>'last_name' AS last_name,
            t.address->>'region' AS state,
            t.username AS username,
            t.shipping_addresses->0->>'vat_number' AS vat_number
        FROM
            {{ source('source_recurly', 'accounts') }} t
    )
    SELECT * FROM tmp
    WHERE first_name IS NOT NULL

{%endif%}
