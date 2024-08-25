{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id as ad_id,
        start_time AS date_hour,
        attachment_quartile_1,
        attachment_quartile_2,
        attachment_quartile_3,
        (attachment_total_view_time_millis / 1000.0) AS attachment_total_view_time,
        attachment_view_completion,
        quartile_1,
        quartile_2,
        quartile_3,
        saves,
        shares,
        (screen_time_millis / 1000.0) AS screen_time,
        video_views,
        view_completion,
        (view_time_millis / 1000.0) AS view_time,
        impressions,
        (spend / 1000.0) AS spend,
        swipes
    FROM
        {{ source('source_snapchat_marketing', 'ads_stats_hourly') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id as ad_id,
        start_time AS date_hour,
        attachment_quartile_1,
        attachment_quartile_2,
        attachment_quartile_3,
        (attachment_total_view_time_millis / 1000.0) AS attachment_total_view_time,
        attachment_view_completion,
        quartile_1,
        quartile_2,
        quartile_3,
        saves,
        shares,
        (screen_time_millis / 1000.0) AS screen_time,
        video_views,
        view_completion,
        (view_time_millis / 1000.0) AS view_time,
        impressions,
        (spend / 1000.0) AS spend,
        swipes
    FROM
        {{ source('source_snapchat_marketing', 'ads_stats_hourly') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id as ad_id,
        start_time AS date_hour,
        attachment_quartile_1,
        attachment_quartile_2,
        attachment_quartile_3,
        (attachment_total_view_time_millis / 1000.0) AS attachment_total_view_time,
        attachment_view_completion,
        quartile_1,
        quartile_2,
        quartile_3,
        saves,
        shares,
        (screen_time_millis / 1000.0) AS screen_time,
        video_views,
        view_completion,
        (view_time_millis / 1000.0) AS view_time,
        impressions,
        (spend / 1000.0) AS spend,
        swipes
    FROM
        {{ source('source_snapchat_marketing', 'ads_stats_hourly') }}
)

SELECT * FROM TMP

{%endif%}
