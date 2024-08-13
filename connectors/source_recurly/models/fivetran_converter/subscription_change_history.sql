{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS subscription_change_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            cast(activated_at AS {{ dbt.type_timestamp() }}) AS activate_at,
            CASE WHEN state = 'active' THEN TRUE ELSE FALSE END AS activated,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            NULL AS deleted_at,
            object,
            NULL AS plan_id,
            quantity,
            id AS subscription_id,
            unit_amount,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_change_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS subscription_change_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            cast(activated_at AS {{ dbt.type_timestamp() }}) AS activate_at,
            CASE WHEN state = 'active' THEN TRUE ELSE FALSE END AS activated,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            NULL AS deleted_at, 
            object,
            NULL AS plan_id,
            quantity,
            id AS subscription_id, -- Using 'id' as both subscription_change_id and subscription_id
            unit_amount,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_change_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS subscription_change_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            cast(activated_at AS {{ dbt.type_timestamp() }}) AS activate_at,
            CASE WHEN state = 'active' THEN TRUE ELSE FALSE END AS activated,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            NULL AS deleted_at,
            object,
            NULL AS plan_id,
            quantity,
            id AS subscription_id,
            unit_amount,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_change_id IS NOT NULL

{% endif %}
