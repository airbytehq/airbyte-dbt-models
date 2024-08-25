{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id AS ad_id,
        name AS ad_name,
        created_at,
        ad_squad_id,
        creative_id,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'ads') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id AS ad_id,
        name AS ad_name,
        created_at,
        ad_squad_id,
        creative_id,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'ads') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id AS ad_id,
        name AS ad_name,
        created_at,
        ad_squad_id,
        creative_id,
        updated_at
    FROM
        {{ source('source_snapchat_marketing', 'ads') }}
)

SELECT * FROM TMP

{%endif%}
