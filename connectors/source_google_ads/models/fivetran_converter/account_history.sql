{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        customer_id AS account_id,
        segments_date AS updated_at,
        customer_currency_code AS currency_code,
        customer_auto_tagging_enabled AS auto_tagging_enabled,
        customer_time_zone AS time_zone,
        customer_descriptive_name AS account_name,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'account_performance_report') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        customer_id AS account_id,
        segments_date AS updated_at,
        customer_currency_code AS currency_code,
        customer_auto_tagging_enabled AS auto_tagging_enabled,
        customer_time_zone AS time_zone,
        customer_descriptive_name AS account_name,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'account_performance_report') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        customer_id AS account_id,
        segments_date AS updated_at,
        customer_currency_code AS currency_code,
        customer_auto_tagging_enabled AS auto_tagging_enabled,
        customer_time_zone AS time_zone,
        customer_descriptive_name AS account_name,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'account_performance_report') }}
)

SELECT * FROM TMP

{% endif %}
