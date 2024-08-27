{% if target.type == "postgres" %}

WITH base AS (
    SELECT
        customer_id AS account_id,
        segments_date AS date_day,
        segments_ad_network_type AS ad_network_type,
        segments_device AS device,
        COALESCE(metrics_clicks, 0) AS clicks,
        COALESCE(metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(metrics_impressions, 0) AS impressions,
        COALESCE(metrics_conversions, 0) AS conversions,
        COALESCE(metrics_conversions_value, 0) AS conversions_value,
        COALESCE(metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'account_performance_report') }}
)

SELECT * FROM base

{% elif target.type == "bigquery" %}

WITH base AS (
    SELECT
        customer_id AS account_id,
        segments_date AS date_day,
        segments_ad_network_type AS ad_network_type,
        segments_device AS device,
        COALESCE(metrics_clicks, 0) AS clicks,
        COALESCE(metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(metrics_impressions, 0) AS impressions,
        COALESCE(metrics_conversions, 0) AS conversions,
        COALESCE(metrics_conversions_value, 0) AS conversions_value,
        COALESCE(metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'account_performance_report') }}
)

SELECT * FROM base

{% elif target.type == "snowflake" %}

WITH base AS (
    SELECT
        customer_id AS account_id,
        segments_date AS date_day,
        segments_ad_network_type AS ad_network_type,
        segments_device AS device,
        COALESCE(metrics_clicks, 0) AS clicks,
        COALESCE(metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(metrics_impressions, 0) AS impressions,
        COALESCE(metrics_conversions, 0) AS conversions,
        COALESCE(metrics_conversions_value, 0) AS conversions_value,
        COALESCE(metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'account_performance_report') }}
)

SELECT * FROM base

{% endif %}
