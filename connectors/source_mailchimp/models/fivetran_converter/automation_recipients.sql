{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        member_id,
        automation_email_id,
        list_id,

        -- The following column is generated in Fivetran and does not have a corresponding field in Airbyte:
        -- automation_recipient_id

    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        member_id,
        automation_email_id,
        list_id

    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        member_id,
        automation_email_id,
        list_id

    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{%endif%}
