{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id AS creative_id,
        created_at,
        ad_account_id,
        name AS creative_name,
        web_view_properties->>'url' AS url,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'creatives') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id AS creative_id,
        created_at,
        ad_account_id,
        name AS creative_name,
        web_view_properties.url AS url,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'creatives') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id AS creative_id,
        created_at,
        ad_account_id,
        name AS creative_name,
        web_view_properties:url AS url,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'creatives') }}
)

SELECT * FROM TMP

{%endif%}
