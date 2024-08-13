{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS plan_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            accounting_code,
            code,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            cast(deleted_at AS {{ dbt.type_timestamp() }}) AS deleted_at,
            description,
            auto_renew AS has_auto_renew,
            interval_length,
            interval_unit,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            tax_exempt AS is_tax_exempt,
            name,
            setup_fee_accounting_code,
            state,
            tax_code,
            total_billing_cycles,
            trial_length,
            trial_unit
        FROM
            {{ source('source_recurly', 'plans') }}
    )
    SELECT * FROM tmp
    WHERE plan_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS plan_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            accounting_code,
            code,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            cast(deleted_at AS {{ dbt.type_timestamp() }}) AS deleted_at,
            description,
            auto_renew AS has_auto_renew,
            interval_length,
            interval_unit,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            tax_exempt AS is_tax_exempt,
            name,
            setup_fee_accounting_code,
            state,
            tax_code,
            total_billing_cycles,
            trial_length,
            trial_unit
        FROM
            {{ source('source_recurly', 'plans') }}
    )
    SELECT * FROM tmp
    WHERE plan_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS plan_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS updated_at,
            accounting_code,
            code,
            cast(created_at AS {{ dbt.type_timestamp() }}) AS created_at,
            cast(deleted_at AS {{ dbt.type_timestamp() }}) AS deleted_at,
            description,
            auto_renew AS has_auto_renew,
            interval_length,
            interval_unit,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record,
            tax_exempt AS is_tax_exempt,
            name,
            setup_fee_accounting_code,
            state,
            tax_code,
            total_billing_cycles,
            trial_length,
            trial_unit
        FROM
            {{ source('source_recurly', 'plans') }}
    )
    SELECT * FROM tmp
    WHERE plan_id IS NOT NULL

{% endif %}
