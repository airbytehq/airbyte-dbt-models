{% if target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            account->>id AS account_id,
            MAX(updated_at) AS account_updated_at,
            SUM(amount) as amount, 
            currency,
            false AS past_due,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY MAX(updated_at) DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'transactions') }}
        GROUP BY account_id, currency
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% elif target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            account:id AS account_id,
            MAX(updated_at) AS account_updated_at,
            SUM(amount) as amount, 
            currency,
            false AS past_due,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY MAX(updated_at) DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'transactions') }}
        GROUP BY account_id, currency
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            JSON_EXTRACT_SCALAR(account, '$.id') AS account_id,
            MAX(updated_at) AS account_updated_at,
            SUM(amount) as amount, 
            currency,
            false AS past_due,
            ROW_NUMBER() OVER (PARTITION BY id ORDER BY MAX(updated_at) DESC) = 1 AS is_most_recent_record
        FROM
            {{ source('source_recurly', 'transactions') }}
        GROUP BY account_id, currency
    )
    SELECT * FROM tmp
    WHERE account_id IS NOT NULL

{% endif %}
