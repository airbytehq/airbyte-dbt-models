
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            adgroup_id AS ad_group_id,
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
            {{ source('source_tiktok_marketing', 'ad_groups_reports_hourly') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            adgroup_id AS ad_group_id,
            CAST(JSON_VALUE(metrics, '$.average_video_play') as float64) AS average_video_play,
            CAST(JSON_VALUE(metrics, '$.average_video_play_per_user') as float64) AS average_video_play_per_user,
            CAST(JSON_VALUE(metrics, '$.clicks') as float64) AS clicks,
            CAST(JSON_VALUE(metrics, '$.comments') as float64) AS comments,
            CAST(JSON_VALUE(metrics, '$.conversion') as float64) AS conversion,
            CAST(JSON_VALUE(metrics, '$.conversion_rate') as float64) AS conversion_rate,
            CAST(JSON_VALUE(metrics, '$.cost_per_conversion') as float64) AS cost_per_conversion,
            CAST(JSON_VALUE(metrics, '$.cpc') as float64) AS cpc,
            CAST(JSON_VALUE(metrics, '$.cpm') as float64) AS cpm,
            CAST(JSON_VALUE(metrics, '$.ctr') as float64) AS ctr,
            CAST(JSON_VALUE(metrics, '$.follows') as float64) AS follows,
            CAST(JSON_VALUE(metrics, '$.impressions') as float64) AS impressions,
            CAST(JSON_VALUE(metrics, '$.likes') as float64) AS likes,
            CAST(JSON_VALUE(metrics, '$.profile_visits') as float64) AS profile_visits,
            CAST(JSON_VALUE(metrics, '$.reach') as float64) AS reach,
            CAST(JSON_VALUE(metrics, '$.shares') as float64) AS shares,
            CAST(JSON_VALUE(metrics, '$.spend') as float64) AS spend,
            stat_time_hour,
            CAST(JSON_VALUE(metrics, '$.video_play_actions') as float64) AS video_play_actions,
            CAST(JSON_VALUE(metrics, '$.video_views_p_25') as float64) AS video_views_p_25,
            CAST(JSON_VALUE(metrics, '$.video_views_p_50')  as float64) aS video_views_p_50,
            CAST(JSON_VALUE(metrics, '$.video_views_p_75') as float64) AS video_views_p_75,
            CAST(JSON_VALUE(metrics, '$.video_watched_2_s') as float64) AS video_watched_2_s,
            CAST(JSON_VALUE(metrics, '$.video_watched_6_s') as float64) AS video_watched_6_s
        FROM
            {{ source('source_tiktok_marketing', 'ad_groups_reports_hourly') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            adgroup_id AS ad_group_id,
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
            {{ source('source_tiktok_marketing', 'ad_groups_reports_hourly') }}
    )

    SELECT * FROM TMP

{%endif%}
