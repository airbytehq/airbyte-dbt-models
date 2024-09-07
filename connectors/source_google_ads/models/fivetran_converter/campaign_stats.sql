{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        apr.customer_id AS account_id,
        apr.segments_date AS date_day,
        campaign.campaign_id AS campaign_id,
        apr.segments_ad_network_type AS ad_network_type,
        apr.segments_device AS device,
        COALESCE(campaign.metrics_clicks, 0) AS clicks,
        COALESCE(campaign.metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(campaign.metrics_impressions, 0) AS impressions,
        COALESCE(campaign.metrics_conversions, 0) AS conversions,
        COALESCE(campaign.metrics_conversions_value, 0) AS conversions_value,
        COALESCE(dkv.metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'account_performance_report') }} apr,
        {{ source('source_google_ads', 'campaign') }} campaign,
        {{ source('source_google_ads', 'display_keyword_view') }} dkv
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        apr.customer_id AS account_id,
        apr.segments_date AS date_day,
        campaign.campaign_id AS campaign_id,
        apr.segments_ad_network_type AS ad_network_type,
        apr.segments_device AS device,
        COALESCE(campaign.metrics_clicks, 0) AS clicks,
        COALESCE(campaign.metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(campaign.metrics_impressions, 0) AS impressions,
        COALESCE(campaign.metrics_conversions, 0) AS conversions,
        COALESCE(campaign.metrics_conversions_value, 0) AS conversions_value,
        COALESCE(dkv.metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'account_performance_report') }} apr,
        {{ source('source_google_ads', 'campaign') }} campaign,
        {{ source('source_google_ads', 'display_keyword_view') }} dkv
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        apr.customer_id AS account_id,
        apr.segments_date AS date_day,
        campaign.campaign_id AS campaign_id,
        apr.segments_ad_network_type AS ad_network_type,
        apr.segments_device AS device,
        COALESCE(campaign.metrics_clicks, 0) AS clicks,
        COALESCE(campaign.metrics_cost_micros, 0) / 1000000.0 AS spend,
        COALESCE(campaign.metrics_impressions, 0) AS impressions,
        COALESCE(campaign.metrics_conversions, 0) AS conversions,
        COALESCE(campaign.metrics_conversions_value, 0) AS conversions_value,
        COALESCE(dkv.metrics_view_through_conversions, 0) AS view_through_conversions
    FROM
        {{ source('source_google_ads', 'account_performance_report') }} apr,
        {{ source('source_google_ads', 'campaign') }} campaign,
        {{ source('source_google_ads', 'display_keyword_view') }} dkv
)

SELECT * FROM TMP

{% endif %}
