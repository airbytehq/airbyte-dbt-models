
{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            NULL AS subscription_id,
            NULL AS updated_at,
            NULL AS account_id,
            NULL AS activated_at,
            NULL AS add_ons_total,
            NULL AS canceled_at,
            NULL AS collection_method,
            NULL AS converted_at,
            NULL AS created_at,
            NULL AS currency,
            NULL AS current_period_ended_at,
            NULL AS current_period_started_at,
            NULL AS current_term_ended_at,
            NULL AS current_term_started_at,
            NULL AS expiration_reason,
            NULL AS expires_at,
            NULL AS has_auto_renew,
            NULL AS has_started_with_gift,
            NULL AS is_most_recent_record,
            NULL AS object,
            NULL AS paused_at,
            NULL AS plan_id,
            NULL AS quantity,
            NULL AS remaining_billing_cycles,
            NULL AS remaining_pause_cycles,
            NULL AS renewal_billing_cycles,
            NULL AS state,
            NULL AS subtotal,
            NULL AS total_billing_cycles,
            NULL AS trial_ends_at,
            NULL AS trial_started_at,
            NULL AS unit_amount,
            NULL AS uuid
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            NULL AS subscription_id,
            NULL AS updated_at,
            NULL AS account_id,
            NULL AS activated_at,
            NULL AS add_ons_total,
            NULL AS canceled_at,
            NULL AS collection_method,
            NULL AS converted_at,
            NULL AS created_at,
            NULL AS currency,
            NULL AS current_period_ended_at,
            NULL AS current_period_started_at,
            NULL AS current_term_ended_at,
            NULL AS current_term_started_at,
            NULL AS expiration_reason,
            NULL AS expires_at,
            NULL AS has_auto_renew,
            NULL AS has_started_with_gift,
            NULL AS is_most_recent_record,
            NULL AS object,
            NULL AS paused_at,
            NULL AS plan_id,
            NULL AS quantity,
            NULL AS remaining_billing_cycles,
            NULL AS remaining_pause_cycles,
            NULL AS renewal_billing_cycles,
            NULL AS state,
            NULL AS subtotal,
            NULL AS total_billing_cycles,
            NULL AS trial_ends_at,
            NULL AS trial_started_at,
            NULL AS unit_amount,
            NULL AS uuid
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            NULL AS subscription_id,
            NULL AS updated_at,
            NULL AS account_id,
            NULL AS activated_at,
            NULL AS add_ons_total,
            NULL AS canceled_at,
            NULL AS collection_method,
            NULL AS converted_at,
            NULL AS created_at,
            NULL AS currency,
            NULL AS current_period_ended_at,
            NULL AS current_period_started_at,
            NULL AS current_term_ended_at,
            NULL AS current_term_started_at,
            NULL AS expiration_reason,
            NULL AS expires_at,
            NULL AS has_auto_renew,
            NULL AS has_started_with_gift,
            NULL AS is_most_recent_record,
            NULL AS object,
            NULL AS paused_at,
            NULL AS plan_id,
            NULL AS quantity,
            NULL AS remaining_billing_cycles,
            NULL AS remaining_pause_cycles,
            NULL AS renewal_billing_cycles,
            NULL AS state,
            NULL AS subtotal,
            NULL AS total_billing_cycles,
            NULL AS trial_ends_at,
            NULL AS trial_started_at,
            NULL AS unit_amount,
            NULL AS uuid
        FROM
            {{ source('source_recurly', 'subscriptions') }}
    )
    SELECT * FROM tmp
    WHERE subscription_id IS NOT NULL

{% endif %}
