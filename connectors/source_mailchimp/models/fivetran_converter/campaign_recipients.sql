{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        campaign_id,
        recipients.email_id AS member_id,
        variate_settings.combination_id,
        recipients.list_id,
        -- email_id is generated in Fivetran, so it is not included here
    FROM
        {{ source('source_mailchimp', 'campaigns') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        campaign_id,
        recipients.email_id AS member_id,
        variate_settings.combination_id,
        recipients.list_id,
        -- email_id is generated in Fivetran, so it is not included here
    FROM
        {{ source('source_mailchimp', 'campaigns') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        campaign_id,
        recipients.email_id AS member_id,
        variate_settings.combination_id,
        recipients.list_id,
        -- email_id is generated in Fivetran, so it is not included here
    FROM
        {{ source('source_mailchimp', 'campaigns') }}
)

SELECT * FROM TMP

{%endif%}
