{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id AS ad_account_id,
        name AS ad_account_name,
        created_at,
        advertiser_organization_id AS advertiser,
        currency,
        timezone,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'adaccounts') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id AS ad_account_id,
        name AS ad_account_name,
        created_at,
        advertiser_organization_id AS advertiser,
        currency,
        timezone,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'adaccounts') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id AS ad_account_id,
        name AS ad_account_name,
        created_at,
        advertiser_organization_id AS advertiser,
        currency,
        timezone,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'adaccounts') }}
)

SELECT * FROM TMP

{%endif%}
