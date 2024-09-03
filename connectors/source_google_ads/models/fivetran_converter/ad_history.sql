{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        ad_group_id AS ad_group_id,
        ad_group_ad_ad_id AS ad_id,
        ad_group_ad_ad_name AS ad_name,
        segments_date AS updated_at,
        ad_group_ad_ad_type AS ad_type,
        ad_group_ad_status AS ad_status,
        ad_group_ad_ad_display_url AS display_url,
        ad_group_ad_ad_final_urls as final_urls,
        ROW_NUMBER() OVER (PARTITION BY ad_group_id, ad_group_ad_ad_id ORDER BY segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'ad_group_ad') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        ad_group_id AS ad_group_id,
        ad_group_ad_ad_id AS ad_id,
        ad_group_ad_ad_name AS ad_name,
        segments_date AS updated_at,
        ad_group_ad_ad_type AS ad_type,
        ad_group_ad_status AS ad_status,
        ad_group_ad_ad_display_url AS display_url,
        to_json_string(ad_group_ad_ad_final_urls) as final_urls,
        ROW_NUMBER() OVER (PARTITION BY ad_group_id, ad_group_ad_ad_id ORDER BY segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'ad_group_ad') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        ad_group_id AS ad_group_id,
        ad_group_ad_ad_id AS ad_id,
        ad_group_ad_ad_name AS ad_name,
        segments_date AS updated_at,
        ad_group_ad_ad_type AS ad_type,
        ad_group_ad_status AS ad_status,
        ad_group_ad_ad_display_url AS display_url,
        cast(ad_group_ad_ad_final_urls as string) as final_urls,
        ROW_NUMBER() OVER (PARTITION BY ad_group_id, ad_group_ad_ad_id ORDER BY segments_date DESC) = 1 AS is_most_recent_record
    FROM
        {{ source('source_google_ads', 'ad_group_ad') }}
)

SELECT * FROM TMP

{% endif %}
