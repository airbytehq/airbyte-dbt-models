{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            NULL AS subscription_add_on_id,
            NULL AS updated_at,
            NULL AS created_at,
            NULL AS expired_at,
            NULL AS object,
            NULL AS plan_add_on_id,
            NULL AS quantity,
            NULL AS subscription_id,
            NULL AS unit_amount,
            NULL AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_add_on_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            NULL AS subscription_add_on_id,
            NULL AS updated_at,
            NULL AS created_at,
            NULL AS expired_at,
            NULL AS object,
            NULL AS plan_add_on_id,
            NULL AS quantity,
            NULL AS subscription_id,
            NULL AS unit_amount,
            NULL AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_add_on_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            NULL AS subscription_add_on_id,
            NULL AS updated_at,
            NULL AS created_at,
            NULL AS expired_at,
            NULL AS object,
            NULL AS plan_add_on_id,
            NULL AS quantity,
            NULL AS subscription_id,
            NULL AS unit_amount,
            NULL AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_add_on_id IS NOT NULL

{% endif %}
