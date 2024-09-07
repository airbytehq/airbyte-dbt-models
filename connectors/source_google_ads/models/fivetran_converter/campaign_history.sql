{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        campaign_id AS campaign_id,
        campaign.segments_date AS updated_at,
        campaign_name AS campaign_name,
        apr.customer_id AS account_id,
        campaign_advertising_channel_type AS advertising_channel_type,
        campaign_advertising_channel_sub_type AS advertising_channel_subtype,
        campaign_start_date AS start_date,
        campaign_end_date AS end_date,
        campaign_serving_status AS serving_status,
        campaign_status AS status,
        campaign_final_url_suffix AS tracking_url_template,
        ROW_NUMBER() OVER (PARTITION BY campaign_id ORDER BY campaign.segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'campaign') }} campaign,
        {{ source('source_google_ads', 'account_performance_report') }} apr
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        campaign_id AS campaign_id,
        campaign.segments_date AS updated_at,
        campaign_name AS campaign_name,
        apr.customer_id AS account_id,
        campaign_advertising_channel_type AS advertising_channel_type,
        campaign_advertising_channel_sub_type AS advertising_channel_subtype,
        campaign_start_date AS start_date,
        campaign_end_date AS end_date,
        campaign_serving_status AS serving_status,
        campaign_status AS status,
        campaign_final_url_suffix AS tracking_url_template,
        ROW_NUMBER() OVER (PARTITION BY campaign_id ORDER BY campaign.segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'campaign') }} campaign,
        {{ source('source_google_ads', 'account_performance_report') }} apr
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        campaign_id AS campaign_id,
        campaign.segments_date AS updated_at,
        campaign_name AS campaign_name,
        apr.customer_id AS account_id,
        campaign_advertising_channel_type AS advertising_channel_type,
        campaign_advertising_channel_sub_type AS advertising_channel_subtype,
        campaign_start_date AS start_date,
        campaign_end_date AS end_date,
        campaign_serving_status AS serving_status,
        campaign_status AS status,
        campaign_final_url_suffix AS tracking_url_template,
        ROW_NUMBER() OVER (PARTITION BY campaign_id ORDER BY campaign.segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'campaign') }} campaign,
        {{ source('source_google_ads', 'account_performance_report') }} apr
)

SELECT * FROM TMP

{% endif %}
