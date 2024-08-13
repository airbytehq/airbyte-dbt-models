{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS billing_id,
            NULL AS updated_at,
            account_id,
            NULL AS billing_city,
            NULL AS billing_country,
            NULL AS billing_phone,
            NULL AS billing_postal_code,
            NULL AS billing_region,
            NULL AS billing_street_1,
            NULL AS billing_street_2,
            company,
            NULL AS created_at,
            first_name,
            NULL AS is_valid,
            last_name,
            NULL AS payment_method_card_type,
            NULL AS payment_method_object,
            NULL AS updated_by_country,
            NULL AS updated_by_ip,
            vat_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY account_id DESC) = 1 AS is_most_recent_record,
            NULL AS fraud_risk_rules_triggered
        FROM
            {{ source('source_recurly', 'billing_infos') }}
    )
    SELECT * FROM tmp
    WHERE billing_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS billing_id,
            NULL AS updated_at,
            account_id,
            NULL AS billing_city,
            NULL AS billing_country,
            NULL AS billing_phone,
            NULL AS billing_postal_code,
            NULL AS billing_region,
            NULL AS billing_street_1,
            NULL AS billing_street_2,
            company,
            NULL AS created_at,
            first_name,
            NULL AS is_valid,
            last_name,
            NULL AS payment_method_card_type, 
            NULL AS payment_method_object,
            NULL AS updated_by_country, 
            NULL AS updated_by_ip, 
            vat_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            NULL AS fraud_risk_rules_triggered
        FROM
            {{ source('source_recurly', 'billing_infos') }}
    )
    SELECT * FROM tmp
    WHERE billing_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS billing_id,
            NULL AS updated_at,
            account_id,
            NULL AS billing_city,
            NULL AS billing_country,
            NULL AS billing_phone,
            NULL AS billing_postal_code,
            NULL AS billing_region,
            NULL AS billing_street_1,
            NULL AS billing_street_2,
            company,
            NULL AS created_at,
            first_name,
            NULL AS is_valid,
            last_name,
            NULL AS payment_method_card_type,
            NULL AS payment_method_object,
            NULL AS updated_by_country,
            NULL AS updated_by_ip,
            vat_number,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY account_id DESC) = 1 AS is_most_recent_record,
            NULL AS fraud_risk_rules_triggered
        FROM
            {{ source('source_recurly', 'billing_infos') }}
    )
    SELECT * FROM tmp
    WHERE billing_id IS NOT NULL

{% endif %}
