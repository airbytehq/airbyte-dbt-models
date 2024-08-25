{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id AS ad_squad_id,
        name AS ad_squad_name,
        created_at,
        campaign_id,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'adsquads') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id AS ad_squad_id,
        name AS ad_squad_name,
        created_at,
        campaign_id,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'adsquads') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id AS ad_squad_id,
        name AS ad_squad_name,
        created_at,
        campaign_id,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'adsquads') }}
)

SELECT * FROM TMP

{%endif%}
