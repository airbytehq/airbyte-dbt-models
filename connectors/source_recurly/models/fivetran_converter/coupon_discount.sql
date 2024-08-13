{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            NULL AS coupon_id,
            NULL AS discount_type,
            NULL AS currency,
            NULL AS amount,
            NULL AS percentage,
            NULL AS trial_length,
            NULL AS trial_unit,
            NULL AS fivetran_id
        FROM
            {{ source('source_recurly', 'coupons') }}
    )
    SELECT * FROM tmp
    WHERE coupon_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            NULL AS coupon_id,
            NULL AS discount_type,
            NULL AS currency,
            NULL AS amount,
            NULL AS percentage,
            NULL AS trial_length,
            NULL AS trial_unit,
            NULL AS fivetran_id
        FROM
            {{ source('source_recurly', 'coupons') }}
    )
    SELECT * FROM tmp
    WHERE coupon_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            NULL AS coupon_id,
            NULL AS discount_type,
            NULL AS currency,
            NULL AS amount,
            NULL AS percentage,
            NULL AS trial_length,
            NULL AS trial_unit,
            NULL AS fivetran_id
        FROM
            {{ source('source_recurly', 'coupons') }}
    )
    SELECT * FROM tmp
    WHERE coupon_id IS NOT NULL

{% endif %}
