
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            action_category_ids AS action_categories,
            action_days,
            adgroup_id,
            adgroup_name,
            advertiser_id,
            age_groups AS age, --FIX
            age_groups,
            audience_type,
            budget,
            campaign_id,
            category_id AS category,
            campaign_name AS display_name,
            frequency,
            frequency_schedule,
            gender,
            interest_category_ids AS interest_category_v_2,
            app_download_url AS landing_page_url,
            languages,
            modify_time AS updated_at
        FROM
            {{ source('source_tiktok_marketing', 'ad_groups') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            action_category_ids AS action_categories,
            action_days,
            adgroup_id,
            adgroup_name,
            advertiser_id,
            age_groups AS age, --FIX
            age_groups,
            audience_type,
            budget,
            campaign_id,
            category_id AS category,
            campaign_name AS display_name,
            frequency,
            frequency_schedule,
            gender,
            interest_category_ids AS interest_category_v_2,
            app_download_url AS landing_page_url,
            languages,
            modify_time AS updated_at
        FROM
            {{ source('source_tiktok_marketing', 'ad_groups') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            action_category_ids AS action_categories,
            action_days,
            adgroup_id,
            adgroup_name,
            advertiser_id,
            age_groups AS age, --FIX
            age_groups,
            audience_type,
            budget,
            campaign_id,
            category_id AS category,
            campaign_name AS display_name,
            frequency,
            frequency_schedule,
            gender,
            interest_category_ids AS interest_category_v_2,
            app_download_url AS landing_page_url,
            languages,
            modify_time AS updated_at
        FROM
            {{ source('source_tiktok_marketing', 'ad_groups') }}
    )

    SELECT * FROM TMP

{%endif%}
