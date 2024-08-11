{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS coupon_redemption_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            coupon_id,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            discounted,
            cast(removed_at AS {{ dbt.type_timestamp() }}) AS removed_at,
            state,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_coupon_redemptions') }}
    )
    SELECT * FROM tmp
    WHERE coupon_redemption_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS coupon_redemption_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            coupon_id,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            discounted,
            cast(removed_at AS {{ dbt.type_timestamp() }}) AS removed_at,
            state,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_coupon_redemptions') }}
    )
    SELECT * FROM tmp
    WHERE coupon_redemption_id IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS coupon_redemption_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            coupon_id,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            discounted,
            cast(removed_at AS {{ dbt.type_timestamp() }}) AS removed_at,
            state,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_coupon_redemptions') }}
    )
    SELECT * FROM tmp
    WHERE coupon_redemption_id IS NOT NULL

{% endif %}