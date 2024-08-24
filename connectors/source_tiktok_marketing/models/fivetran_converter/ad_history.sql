
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            
            ad_id,
            ad_name,
            adgroup_id,
            advertiser_id,
            call_to_action,
            campaign_id,
            click_tracking_url,
            impression_tracking_url,
            landing_page_url,
            modify_time AS updated_at

        FROM
            {{ source('source_tiktok_marketing', 'ads') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            
            ad_id,
            ad_name,
            adgroup_id,
            advertiser_id,
            call_to_action,
            campaign_id,
            click_tracking_url,
            impression_tracking_url,
            landing_page_url,
            modify_time AS updated_at

        FROM
            {{ source('source_tiktok_marketing', 'ads') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            
            ad_id,
            ad_name,
            adgroup_id,
            advertiser_id,
            call_to_action,
            campaign_id,
            click_tracking_url,
            impression_tracking_url,
            landing_page_url,
            modify_time AS updated_at

        FROM
            {{ source('source_tiktok_marketing', 'ads') }}
    )

    SELECT * FROM TMP

{%endif%}
    