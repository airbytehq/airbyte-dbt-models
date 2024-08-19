{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS billing_id,
            updated_at,
            account_id,
            address->>'city' AS billing_city,
            address->>'country' AS billing_country,
            address->>'phone' AS billing_phone,
            address->>'postal_code' AS billing_postal_code,
            address->>'region' AS billing_region,
            address->>'street1' AS billing_street_1,
            address->>'street2' AS billing_street_2,
            company,
            created_at,
            first_name,
            valid::boolean AS is_valid,
            last_name,
            payment_method->>'card_type' AS payment_method_card_type,
            payment_method->>'object' AS payment_method_object,
            updated_by->>'country' AS updated_by_country,
            updated_by->>'ip' AS updated_by_ip,
            vat_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY account_id DESC) = 1 AS is_most_recent_record,
            fraud->>'risk_rules_triggered' AS fraud_risk_rules_triggered
        FROM
            {{ source('source_recurly', 'billing_infos') }}
    )
    SELECT * FROM tmp
    WHERE billing_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS billing_id,
            updated_at,
            account_id,
            address:city::STRING AS billing_city,
            address:country::STRING AS billing_country,
            address:phone::STRING AS billing_phone,
            address:postal_code::STRING AS billing_postal_code,
            address:region::STRING AS billing_region,
            address:street1::STRING AS billing_street_1,
            address:street2::STRING AS billing_street_2,
            company,
            created_at,
            first_name,
            valid::BOOLEAN AS is_valid,
            last_name,
            payment_method:card_type::STRING AS payment_method_card_type,
            payment_method:object::STRING AS payment_method_object,
            updated_by:country::STRING AS updated_by_country,
            updated_by:ip::STRING AS updated_by_ip,
            vat_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY account_id DESC) = 1 AS is_most_recent_record,
            fraud:risk_rules_triggered::STRING AS fraud_risk_rules_triggered
        FROM
            {{ source('source_recurly', 'billing_infos') }}
    )
    SELECT * FROM tmp
    WHERE billing_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS billing_id,
            updated_at,
            account_id,
            address.city AS billing_city,
            address.country AS billing_country,
            address.phone AS billing_phone,
            address.postal_code AS billing_postal_code,
            address.region AS billing_region,
            address.street1 AS billing_street_1,
            address.street2 AS billing_street_2,
            company,
            created_at,
            first_name,
            valid AS is_valid,
            last_name,
            payment_method.card_type AS payment_method_card_type,
            payment_method.object AS payment_method_object,
            updated_by.country AS updated_by_country,
            updated_by.ip AS updated_by_ip,
            vat_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY account_id DESC) = 1 AS is_most_recent_record,
            fraud.risk_rules_triggered AS fraud_risk_rules_triggered
        FROM
            {{ source('source_recurly', 'billing_infos') }}
    )
    SELECT * FROM tmp
    WHERE billing_id IS NOT NULL

{% endif %}
