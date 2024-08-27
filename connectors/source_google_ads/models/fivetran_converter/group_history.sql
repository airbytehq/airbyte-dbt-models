{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        ad_group_id AS ad_group_id,
        segments_date AS updated_at,
        ad_group_type AS ad_group_type,
        campaign_id AS campaign_id,
        (SELECT campaign_name FROM {{ source('source_google_ads', 'campaign') }} WHERE campaign_id = ad_group.campaign_id LIMIT 1) AS campaign_name,
        ad_group_name AS ad_group_name,
        ad_group_status AS ad_group_status,
        ROW_NUMBER() OVER (PARTITION BY ad_group.ad_group_id ORDER BY ad_group.segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'ad_group') }} ad_group
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        ad_group_id AS ad_group_id,
        segments_date AS updated_at,
        ad_group_type AS ad_group_type,
        campaign_id AS campaign_id,
        (SELECT campaign_name FROM {{ source('source_google_ads', 'campaign') }} WHERE campaign_id = ad_group.campaign_id LIMIT 1) AS campaign_name,
        ad_group_name AS ad_group_name,
        ad_group_status AS ad_group_status,
        ROW_NUMBER() OVER (PARTITION BY ad_group.ad_group_id ORDER BY ad_group.segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'ad_group') }} ad_group
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        ad_group_id AS ad_group_id,
        segments_date AS updated_at,
        ad_group_type AS ad_group_type,
        campaign_id AS campaign_id,
        (SELECT campaign_name FROM {{ source('source_google_ads', 'campaign') }} WHERE campaign_id = ad_group.campaign_id LIMIT 1) AS campaign_name,
        ad_group_name AS ad_group_name,
        ad_group_status AS ad_group_status,
        ROW_NUMBER() OVER (PARTITION BY ad_group.ad_group_id ORDER BY ad_group.segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'ad_group') }} ad_group
)

SELECT * FROM TMP

{% endif %}
