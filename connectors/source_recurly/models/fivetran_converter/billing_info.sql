{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS billing_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            city AS billing_city,
            country AS billing_country,
            phone AS billing_phone,
            zip AS billing_postal_code,
            state AS billing_region,
            address1 AS billing_street_1,
            address2 AS billing_street_2,
            company,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            first_name,
            verified AS is_valid,
            last_name,
            NULL AS payment_method_card_type, 
            payment_type AS payment_method_object,
            NULL AS updated_by_country, 
            NULL AS updated_by_ip, 
            vat_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'billing_infos') }}
    )
    SELECT * FROM tmp
    WHERE billing_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS billing_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            city AS billing_city,
            country AS billing_country,
            phone AS billing_phone,
            zip AS billing_postal_code,
            state AS billing_region,
            address1 AS billing_street_1,
            address2 AS billing_street_2,
            company,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            first_name,
            verified AS is_valid,
            last_name,
            NULL AS payment_method_card_type,
            payment_type AS payment_method_object,
            NULL AS updated_by_country,
            NULL AS updated_by_ip,
            vat_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'billing_infos') }}
    )
    SELECT * FROM tmp
    WHERE billing_id IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS billing_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            city AS billing_city,
            country AS billing_country,
            phone AS billing_phone,
            zip AS billing_postal_code,
            state AS billing_region,
            address1 AS billing_street_1,
            address2 AS billing_street_2,
            company,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            first_name,
            verified AS is_valid,
            last_name,
            NULL AS payment_method_card_type,
            payment_type AS payment_method_object,
            NULL AS updated_by_country,
            NULL AS updated_by_ip,
            vat_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'billing_infos') }}
    )
    SELECT * FROM tmp
    WHERE billing_id IS NOT NULL

{% endif %}
