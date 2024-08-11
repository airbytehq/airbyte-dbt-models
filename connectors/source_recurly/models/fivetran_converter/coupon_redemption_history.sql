{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            t.id AS coupon_redemption_id,
            cast(t.updated_at as {{ dbt.type_timestamp() }}) AS updated_at,
            t.account_id AS account_id,
            t.coupon_id AS coupon_id,
            cast(t.created_at as {{ dbt.type_timestamp() }}) AS created_at,
            t.currency AS currency, 
            t.discounted AS discounted, 
            cast(t.removed_at as {{ dbt.type_timestamp() }}) AS removed_at,
            t.state AS state,
            ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY t.updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_coupon_redemptions') }} t
    )
    SELECT * FROM tmp
    WHERE field_name IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            t.id AS coupon_redemption_id,
            cast(t.updated_at as {{ dbt.type_timestamp() }}) AS updated_at,
            t.account_id AS account_id,
            t.coupon_id AS coupon_id,
            cast(t.created_at as {{ dbt.type_timestamp() }}) AS created_at,
            t.currency AS currency, 
            t.discounted AS discounted, 
            cast(t.removed_at as {{ dbt.type_timestamp() }}) AS removed_at,
            t.state AS state,
            ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY t.updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_coupon_redemptions') }} t
    )
    SELECT * FROM tmp
    WHERE FIELD_NAME IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            t.id AS coupon_redemption_id,
            cast(t.updated_at as {{ dbt.type_timestamp() }}) AS updated_at,
            t.coupon_id AS coupon_id,
            cast(t.created_at as {{ dbt.type_timestamp() }}) AS created_at,
            t.currency AS currency, 
            t.discounted AS discounted, 
            cast(t.removed_at as {{ dbt.type_timestamp() }}) AS removed_at,
            t.state AS state,
            ROW_NUMBER() OVER (PARTITION BY t.id ORDER BY t.updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'account_coupon_redemptions') }} t
    )
    SELECT * FROM tmp
    WHERE coupon_redemption_id IS NOT NULL

{% endif %}
