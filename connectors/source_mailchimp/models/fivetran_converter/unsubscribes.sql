{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        campaign_id,
        email_id AS member_id,
        list_id,
        reason AS unsubscribe_reason,
        timestamp AS unsubscribe_timestamp
    FROM
        {{ source('source_mailchimp', 'unsubscribes') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        campaign_id,
        email_id AS member_id,
        list_id,
        reason AS unsubscribe_reason,
        timestamp AS unsubscribe_timestamp
    FROM
        {{ source('source_mailchimp', 'unsubscribes') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        campaign_id,
        email_id AS member_id,
        list_id,
        reason AS unsubscribe_reason,
        timestamp AS unsubscribe_timestamp
    FROM
        {{ source('source_mailchimp', 'unsubscribes') }}
)

SELECT * FROM TMP

{%endif%}
