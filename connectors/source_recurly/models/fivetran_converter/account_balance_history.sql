{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            account->>id AS account_id,
            updated_at AS account_updated_at,
            sum(amount) as amount, 
            currency,
            has_past_due_invoice AS past_due,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'transactions') }}
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            account:id AS account_id,
            updated_at AS account_updated_at,
            sum(amount) as amount, 
            currency,
            has_past_due_invoice AS past_due,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'transactions') }}
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            JSON_EXTRACT_SCALAR(account, '$.id') AS account_id,
            updated_at AS account_updated_at,
            sum(amount) as amount, 
            currency,
            has_past_due_invoice AS past_due,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'transactions') }}
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% endif %}
