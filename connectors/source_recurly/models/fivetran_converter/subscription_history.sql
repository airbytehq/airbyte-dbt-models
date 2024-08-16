{% set column_names = adapter.get_columns_in_relation(source('source_recurly', 'subscriptions')) | map(attribute='name') | list %}

{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS subscription_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            cast(activated_at AS {{ dbt.type_timestamp() }}) AS activated_at,
            CAST(NULL AS {{ dbt.type_float() }}) AS add_ons_total,
            cast(canceled_at AS {{ dbt.type_timestamp() }}) AS canceled_at,
            collection_method,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS converted_at,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_period_ended_at,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_period_started_at,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_term_ended_at,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_term_started_at,
            CAST(NULL AS STRING) AS expiration_reason,
            cast(expires_at AS {{ dbt.type_timestamp() }}) AS expires_at,
            CAST(NULL AS BOOLEAN) AS has_auto_renew,
            CAST(NULL AS BOOLEAN) AS has_started_with_gift,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            object,
            cast(paused_at AS {{ dbt.type_timestamp() }}) AS paused_at,
            plan_id,
            quantity,
            CAST(NULL AS {{ dbt.type_int() }}) AS remaining_billing_cycles,
            remaining_pause_cycles,
            renewal_billing_cycle AS renewal_billing_cycles,
            state,
            CAST(NULL AS {{ dbt.type_float() }}) AS subtotal,
            CAST(NULL AS {{ dbt.type_int() }}) AS total_billing_cycles,
            cast(trial_ends_at AS {{ dbt.type_timestamp() }}) AS trial_ends_at,
            cast(trial_started_at AS {{ dbt.type_timestamp() }}) AS trial_started_at,
            cast(unit_amount AS {{ dbt.type_float() }}) AS unit_amount,
            id AS uuid
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS subscription_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            cast(activated_at AS {{ dbt.type_timestamp() }}) AS activated_at,
            CAST(NULL AS {{ dbt.type_float() }}) AS add_ons_total,
            cast(canceled_at AS {{ dbt.type_timestamp() }}) AS canceled_at,
            collection_method,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS converted_at,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_period_ended_at,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_period_started_at,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_term_ended_at,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_term_started_at,
            CAST(NULL AS STRING) AS expiration_reason,
            cast(expires_at AS {{ dbt.type_timestamp() }}) AS expires_at,
            CAST(NULL AS BOOLEAN) AS has_auto_renew,
            CAST(NULL AS BOOLEAN) AS has_started_with_gift,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            object,
            cast(paused_at AS {{ dbt.type_timestamp() }}) AS paused_at,
            plan_id,
            quantity,
            CAST(NULL AS {{ dbt.type_int() }}) AS remaining_billing_cycles,
            remaining_pause_cycles,
            renewal_billing_cycle AS renewal_billing_cycles,
            state,
            CAST(NULL AS {{ dbt.type_float() }}) AS subtotal,
            CAST(NULL AS {{ dbt.type_int() }}) AS total_billing_cycles,
            cast(trial_ends_at AS {{ dbt.type_timestamp() }}) AS trial_ends_at,
            cast(trial_started_at AS {{ dbt.type_timestamp() }}) AS trial_started_at,
            cast(unit_amount AS {{ dbt.type_float() }}) AS unit_amount,
            id AS uuid
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS subscription_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            account_id,
            cast(activated_at AS {{ dbt.type_timestamp() }}) AS activated_at,
            CAST(NULL AS {{ dbt.type_float() }}) AS add_ons_total,
            cast(canceled_at AS {{ dbt.type_timestamp() }}) AS canceled_at,
            collection_method,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS converted_at,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            currency,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_period_ended_at,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_period_started_at,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_term_ended_at,
            CAST(NULL AS {{ dbt.type_timestamp() }}) AS current_term_started_at,
            CAST(NULL AS STRING) AS expiration_reason,
            cast(expires_at AS {{ dbt.type_timestamp() }}) AS expires_at,
            CAST(NULL AS BOOLEAN) AS has_auto_renew,
            CAST(NULL AS BOOLEAN) AS has_started_with_gift,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            object,
            cast(paused_at AS {{ dbt.type_timestamp() }}) AS paused_at,
            plan_id,
            quantity,
            CAST(NULL AS {{ dbt.type_int() }}) AS remaining_billing_cycles,
            remaining_pause_cycles,
            renewal_billing_cycle AS renewal_billing_cycles,
            state,
            CAST(NULL AS {{ dbt.type_float() }}) AS subtotal,
            CAST(NULL AS {{ dbt.type_int() }}) AS total_billing_cycles,
            cast(trial_ends_at AS {{ dbt.type_timestamp() }}) AS trial_ends_at,
            cast(trial_started_at AS {{ dbt.type_timestamp() }}) AS trial_started_at,
            cast(unit_amount AS {{ dbt.type_float() }}) AS unit_amount,
            id AS uuid
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_id IS NOT NULL

{% endif %}