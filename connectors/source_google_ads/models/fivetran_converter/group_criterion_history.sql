{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        ad_group_criterion_criterion_id AS criterion_id,
        ad_group_id AS ad_group_id,
        (SELECT campaign_base_campaign FROM {{ source('source_google_ads', 'display_keyword_view') }} WHERE ad_group_id = agc.ad_group_id LIMIT 1) AS base_campaign_id,
        change_status_last_change_date_time AS updated_at,
        ad_group_criterion_type AS type,
        ad_group_criterion_status AS status,
        ad_group_criterion_keyword_match_type AS keyword_match_type,
        ad_group_criterion_keyword_text AS keyword_text,
        ROW_NUMBER() OVER (PARTITION BY ad_group_criterion_criterion_id ORDER BY change_status_last_change_date_time DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'ad_group_criterion') }} agc
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        ad_group_criterion_criterion_id AS criterion_id,
        ad_group_id AS ad_group_id,
        (SELECT campaign_base_campaign FROM {{ source('source_google_ads', 'display_keyword_view') }} WHERE ad_group_id = agc.ad_group_id LIMIT 1) AS base_campaign_id,
        change_status_last_change_date_time AS updated_at,
        ad_group_criterion_type AS type,
        ad_group_criterion_status AS status,
        ad_group_criterion_keyword_match_type AS keyword_match_type,
        ad_group_criterion_keyword_text AS keyword_text,
        ROW_NUMBER() OVER (PARTITION BY ad_group_criterion_criterion_id ORDER BY change_status_last_change_date_time DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'ad_group_criterion') }} agc
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        ad_group_criterion_criterion_id AS criterion_id,
        ad_group_id AS ad_group_id,
        (SELECT campaign_base_campaign FROM {{ source('source_google_ads', 'display_keyword_view') }} WHERE ad_group_id = agc.ad_group_id LIMIT 1) AS base_campaign_id,
        change_status_last_change_date_time AS updated_at,
        ad_group_criterion_type AS type,
        ad_group_criterion_status AS status,
        ad_group_criterion_keyword_match_type AS keyword_match_type,
        ad_group_criterion_keyword_text AS keyword_text,
        ROW_NUMBER() OVER (PARTITION BY ad_group_criterion_criterion_id ORDER BY change_status_last_change_date_time DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'ad_group_criterion') }} agc
)

SELECT * FROM TMP

{% endif %}
