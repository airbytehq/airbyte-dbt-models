{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        apr.customer_id AS account_id,
        ag_ad.segments_date AS date_day,
        ag_ad.ad_group_id AS ad_group_id,
        ag.campaign_id AS campaign_id,
        ag_ad.ad_group_ad_ad_device_preference AS device,
        apr.segments_ad_network_type AS ad_network_type,
        COALESCE(apr.metrics_clicks, 0) AS clicks,
        COALESCE(apr.metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(apr.metrics_impressions, 0) AS impressions,
        COALESCE(apr.metrics_conversions, 0) AS conversions,
        COALESCE(apr.metrics_conversions_value, 0) AS conversions_value,
        COALESCE(apr.metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'account_performance_report') }} apr,
        {{ source('source_google_ads', 'ad_group_ad') }} ag_ad,
        {{ source('source_google_ads', 'ad_group') }} ag
    WHERE
        ag_ad.ad_group_id = ag.ad_group_id
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        apr.customer_id AS account_id,
        ag_ad.segments_date AS date_day,
        ag_ad.ad_group_id AS ad_group_id,
        ag.campaign_id AS campaign_id,
        ag_ad.ad_group_ad_ad_device_preference AS device,
        apr.segments_ad_network_type AS ad_network_type,
        COALESCE(apr.metrics_clicks, 0) AS clicks,
        COALESCE(apr.metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(apr.metrics_impressions, 0) AS impressions,
        COALESCE(apr.metrics_conversions, 0) AS conversions,
        COALESCE(apr.metrics_conversions_value, 0) AS conversions_value,
        COALESCE(apr.metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'account_performance_report') }} apr,
        {{ source('source_google_ads', 'ad_group_ad') }} ag_ad,
        {{ source('source_google_ads', 'ad_group') }} ag
    WHERE
        ag_ad.ad_group_id = ag.ad_group_id
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        apr.customer_id AS account_id,
        ag_ad.segments_date AS date_day,
        ag_ad.ad_group_id AS ad_group_id,
        ag.campaign_id AS campaign_id,
        ag_ad.ad_group_ad_ad_device_preference AS device,
        apr.segments_ad_network_type AS ad_network_type,
        COALESCE(apr.metrics_clicks, 0) AS clicks,
        COALESCE(apr.metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(apr.metrics_impressions, 0) AS impressions,
        COALESCE(apr.metrics_conversions, 0) AS conversions,
        COALESCE(apr.metrics_conversions_value, 0) AS conversions_value,
        COALESCE(apr.metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'account_performance_report') }} apr,
        {{ source('source_google_ads', 'ad_group_ad') }} ag_ad,
        {{ source('source_google_ads', 'ad_group') }} ag
    WHERE
        ag_ad.ad_group_id = ag.ad_group_id
)

SELECT * FROM TMP

{% endif %}
