{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS subscription_add_on_id,
            updated_at,
            created_at,
            NULL AS expired_at,
            NULL AS object,
            plan_id AS plan_add_on_id,
            default_quantity AS quantity,
            id AS subscription_id,
            currencies->>unit_amount AS unit_amount,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'add_ons') }}
    )
    SELECT * FROM tmp
    WHERE subscription_add_on_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS subscription_add_on_id,
            updated_at,
            created_at,
            NULL AS expired_at,
            NULL AS object,
            plan_id AS plan_add_on_id,
            default_quantity AS quantity,
            id AS subscription_id,
            currencies:"unit_amount"::string AS unit_amount,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'add_ons') }}
    )
    SELECT * FROM tmp
    WHERE subscription_add_on_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS subscription_add_on_id,
            updated_at,
            created_at,
            NULL AS expired_at,
            NULL AS object,
            plan_id AS plan_add_on_id,
            default_quantity AS quantity,
            id AS subscription_id,
            JSON_EXTRACT_SCALAR(currencies, '$.unit_amount') AS unit_amount,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'add_ons') }}
    )
    SELECT * FROM tmp
    WHERE subscription_add_on_id IS NOT NULL

{% endif %}
