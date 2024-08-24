
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            ad_id,
            metrics->>'average_video_play' AS average_video_play,
            metrics->>'average_video_play_per_user' AS average_video_play_per_user,
            metrics->>'clicks' AS clicks,
            metrics->>'comments' AS comments,
            metrics->>'conversion' AS conversion,
            metrics->>'conversion_rate' AS conversion_rate,
            metrics->>'cost_per_conversion' AS cost_per_conversion,
            metrics->>'cpc' AS cpc,
            metrics->>'cpm' AS cpm,
            metrics->>'ctr' AS ctr,
            metrics->>'follows' AS follows,
            metrics->>'impressions' AS impressions,
            metrics->>'likes' AS likes,
            metrics->>'profile_visits' AS profile_visits,
            metrics->>'reach' AS reach,
            metrics->>'shares' AS shares,
            metrics->>'spend' AS spend,
            stat_time_hour,
            metrics->>'video_play_actions' AS video_play_actions,
            metrics->>'video_views_p_25' AS video_views_p_25,
            metrics->>'video_views_p_50' AS video_views_p_50,
            metrics->>'video_views_p_75' AS video_views_p_75,
            metrics->>'video_watched_2_s' AS video_watched_2_s,
            metrics->>'video_watched_6_s' AS video_watched_6_s
        FROM
            {{ source('source_tiktok_marketing', 'ads_reports_hourly') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            ad_id,
            JSON_EXTRACT_SCALAR(metrics, '$.average_video_play') AS average_video_play,
            JSON_EXTRACT_SCALAR(metrics, '$.average_video_play_per_user') AS average_video_play_per_user,
            JSON_EXTRACT_SCALAR(metrics, '$.clicks') AS clicks,
            JSON_EXTRACT_SCALAR(metrics, '$.comments') AS comments,
            JSON_EXTRACT_SCALAR(metrics, '$.conversion') AS conversion,
            JSON_EXTRACT_SCALAR(metrics, '$.conversion_rate') AS conversion_rate,
            JSON_EXTRACT_SCALAR(metrics, '$.cost_per_conversion') AS cost_per_conversion,
            JSON_EXTRACT_SCALAR(metrics, '$.cpc') AS cpc,
            JSON_EXTRACT_SCALAR(metrics, '$.cpm') AS cpm,
            JSON_EXTRACT_SCALAR(metrics, '$.ctr') AS ctr,
            JSON_EXTRACT_SCALAR(metrics, '$.follows') AS follows,
            JSON_EXTRACT_SCALAR(metrics, '$.impressions') AS impressions,
            JSON_EXTRACT_SCALAR(metrics, '$.likes') AS likes,
            JSON_EXTRACT_SCALAR(metrics, '$.profile_visits') AS profile_visits,
            JSON_EXTRACT_SCALAR(metrics, '$.reach') AS reach,
            JSON_EXTRACT_SCALAR(metrics, '$.shares') AS shares,
            JSON_EXTRACT_SCALAR(metrics, '$.spend') AS spend,
            stat_time_hour,
            JSON_EXTRACT_SCALAR(metrics, '$.video_play_actions') AS video_play_actions,
            JSON_EXTRACT_SCALAR(metrics, '$.video_views_p_25') AS video_views_p_25,
            JSON_EXTRACT_SCALAR(metrics, '$.video_views_p_50') AS video_views_p_50,
            JSON_EXTRACT_SCALAR(metrics, '$.video_views_p_75') AS video_views_p_75,
            JSON_EXTRACT_SCALAR(metrics, '$.video_watched_2_s') AS video_watched_2_s,
            JSON_EXTRACT_SCALAR(metrics, '$.video_watched_6_s') AS video_watched_6_s
        FROM
            {{ source('source_tiktok_marketing', 'ads_reports_hourly') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            ad_id,
            metrics:"average_video_play"::string AS average_video_play,
            metrics:"average_video_play_per_user"::string AS average_video_play_per_user,
            metrics:"clicks"::string AS clicks,
            metrics:"comments"::string AS comments,
            metrics:"conversion"::string AS conversion,
            metrics:"conversion_rate"::string AS conversion_rate,
            metrics:"cost_per_conversion"::string AS cost_per_conversion,
            metrics:"cpc"::string AS cpc,
            metrics:"cpm"::string AS cpm,
            metrics:"ctr"::string AS ctr,
            metrics:"follows"::string AS follows,
            metrics:"impressions"::string AS impressions,
            metrics:"likes"::string AS likes,
            metrics:"profile_visits"::string AS profile_visits,
            metrics:"reach"::string AS reach,
            metrics:"shares"::string AS shares,
            metrics:"spend"::string AS spend,
            stat_time_hour,
            metrics:"video_play_actions"::string AS video_play_actions,
            metrics:"video_views_p_25"::string AS video_views_p_25,
            metrics:"video_views_p_50"::string AS video_views_p_50,
            metrics:"video_views_p_75"::string AS video_views_p_75,
            metrics:"video_watched_2_s"::string AS video_watched_2_s,
            metrics:"video_watched_6_s"::string AS video_watched_6_s
        FROM
            {{ source('source_tiktok_marketing', 'ads_reports_hourly') }}
    )

    SELECT * FROM TMP

{%endif%}
    