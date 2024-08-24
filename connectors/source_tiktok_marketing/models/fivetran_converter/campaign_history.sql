
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            
            advertiser_id,
            campaign_id,
            campaign_name,
            campaign_type,
            split_test_variable,
            modify_time AS updated_at

        FROM
            {{ source('source_tiktok_marketing', 'campaigns') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            
            advertiser_id,
            campaign_id,
            campaign_name,
            campaign_type,
            split_test_variable,
            modify_time AS updated_at

        FROM
            {{ source('source_tiktok_marketing', 'campaigns') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            
            advertiser_id,
            campaign_id,
            campaign_name,
            campaign_type,
            split_test_variable,
            modify_time AS updated_at

        FROM
            {{ source('source_tiktok_marketing', 'campaigns') }}
    )

    SELECT * FROM TMP

{%endif%}
