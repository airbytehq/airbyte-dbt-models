{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS account_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS account_updated_at,
            NULL AS amount, 
            NULL AS currency, 
            has_past_due_invoice AS past_due,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'accounts') }}
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS account_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS account_updated_at,
            NULL AS amount, 
            NULL AS currency, 
            has_past_due_invoice AS past_due,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'accounts') }}
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS account_id,
            cast(updated_at AS {{ dbt.type_timestamp() }}) AS account_updated_at,
            NULL AS amount, 
            NULL AS currency,  
            has_past_due_invoice AS past_due,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'accounts') }}
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% endif %}