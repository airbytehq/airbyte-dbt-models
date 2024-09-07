{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        kwv.customer_id AS account_id,
        kwv.segments_date AS date_day,
        kwv.ad_group_id AS ad_group_id,
        kwv.ad_group_criterion_criterion_id AS criterion_id,
        kwv.campaign_id AS campaign_id,
        COALESCE(kwv.metrics_clicks, 0) AS clicks,
        COALESCE(kwv.metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(kwv.metrics_impressions, 0) AS impressions,
        COALESCE(kwv.metrics_conversions, 0) AS conversions,
        COALESCE(kwv.metrics_conversions_value, 0) AS conversions_value,
        COALESCE(kwv.metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'keyword_view') }} kwv
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        kwv.customer_id AS account_id,
        kwv.segments_date AS date_day,
        kwv.ad_group_id AS ad_group_id,
        kwv.ad_group_criterion_criterion_id AS criterion_id,
        kwv.campaign_id AS campaign_id,
        COALESCE(kwv.metrics_clicks, 0) AS clicks,
        COALESCE(kwv.metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(kwv.metrics_impressions, 0) AS impressions,
        COALESCE(kwv.metrics_conversions, 0) AS conversions,
        COALESCE(kwv.metrics_conversions_value, 0) AS conversions_value,
        COALESCE(kwv.metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'keyword_view') }} kwv
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        kwv.customer_id AS account_id,
        kwv.segments_date AS date_day,
        kwv.ad_group_id AS ad_group_id,
        kwv.ad_group_criterion_criterion_id AS criterion_id,
        kwv.campaign_id AS campaign_id,
        COALESCE(kwv.metrics_clicks, 0) AS clicks,
        COALESCE(kwv.metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(kwv.metrics_impressions, 0) AS impressions,
        COALESCE(kwv.metrics_conversions, 0) AS conversions,
        COALESCE(kwv.metrics_conversions_value, 0) AS conversions_value,
        COALESCE(kwv.metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'keyword_view') }} kwv
)

SELECT * FROM TMP

{% endif %}
