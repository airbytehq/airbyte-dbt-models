{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id AS campaign_id,
        ad_account_id,
        created_at,
        name AS campaign_name,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'campaigns') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id AS campaign_id,
        ad_account_id,
        created_at,
        name AS campaign_name,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'campaigns') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id AS campaign_id,
        ad_account_id,
        created_at,
        name AS campaign_name,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'campaigns') }}
)

SELECT * FROM TMP

{%endif%}
