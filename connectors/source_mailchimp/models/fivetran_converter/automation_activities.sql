{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        recipients.member_id AS member_id,
        recipients.list_id AS list_id,
        start_time AS activity_timestamp

        -- The following columns are not present in the Airbyte schema:
        -- action_type (action)
        -- automation_email_id
        -- ip_address (ip)
        -- url
        -- bounce_type
        -- activity_id (Generated)

    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        recipients.member_id AS member_id,
        recipients.list_id AS list_id,
        start_time AS activity_timestamp
    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        recipients.member_id AS member_id,
        recipients.list_id AS list_id,
        start_time AS activity_timestamp
    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{%endif%}
