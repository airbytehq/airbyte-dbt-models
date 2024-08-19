{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS plan_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS plan_updated_at,
            NULL AS currency,
            NULL AS setup_fees,
            NULL AS unit_amount,
            NULL AS is_most_recent_record
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
            NULL AS currency,
            NULL AS setup_fees,
            NULL AS unit_amount,
            NULL AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'plans') }}
    )
    SELECT * FROM tmp
    WHERE plan_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            NULL AS plan_id,
            NULL AS plan_updated_at,
            NULL AS currency,
            NULL AS setup_fees,
            NULL AS unit_amount,
            NULL AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'plans') }}
    )
    SELECT * FROM tmp
    WHERE plan_id IS NOT NULL

{% endif %}
