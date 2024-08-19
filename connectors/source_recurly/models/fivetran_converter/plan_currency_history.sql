{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS plan_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS plan_updated_at,
            currencies->>'currency' AS currency,
            currencies->>'setup_fee' AS setup_fees,
            currencies->>'unit_amount' AS unit_amount,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'plans') }}
    )
    SELECT * FROM tmp
    WHERE plan_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS plan_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS plan_updated_at,
            currencies:currency::STRING AS currency,
            currencies:setup_fee::STRING AS setup_fees,
            currencies:unit_amount AS unit_amount,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'plans') }}
    )
    SELECT * FROM tmp
    WHERE plan_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS plan_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS plan_updated_at,
            currencies.currency AS currency,
            currencies.setup_fee AS setup_fees,
            currencies.unit_amount AS unit_amount,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'plans') }}
    )
    SELECT * FROM tmp
    WHERE plan_id IS NOT NULL

{% endif %}
