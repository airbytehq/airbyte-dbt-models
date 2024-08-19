{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS coupon_id,
            discount->>'type' AS discount_type,
            discount->'currencies'->>'currency' AS currency,
            free_trial_amount AS amount,
            discount->>'percent' AS percentage,
            duration AS trial_length,
            free_trial_unit AS trial_unit,
            NULL AS fivetran_id
        FROM
            {{ source('source_recurly', 'coupons') }}
    )
    SELECT * FROM tmp
    WHERE coupon_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS coupon_id,
            discount:"type"::string AS discount_type,
            discount:"currencies":"currency"::string AS currency,
            free_trial_amount AS amount,
            discount:"percent"::string AS percentage,
            duration AS trial_length,
            free_trial_unit AS trial_unit,
            NULL AS fivetran_id
        FROM
            {{ source('source_recurly', 'coupons') }}
    )
    SELECT * FROM tmp
    WHERE coupon_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS coupon_id,
            JSON_EXTRACT_SCALAR(discount, '$.type') AS discount_type,
            JSON_EXTRACT_SCALAR(discount, '$.currencies.currency') AS currency,
            free_trial_amount AS amount,
            JSON_EXTRACT_SCALAR(discount, '$.percent') AS percentage,
            duration AS trial_length,
            free_trial_unit AS trial_unit,
            NULL AS fivetran_id
        FROM
            {{ source('source_recurly', 'coupons') }}
    )
    SELECT * FROM tmp
    WHERE coupon_id IS NOT NULL

{% endif %}
