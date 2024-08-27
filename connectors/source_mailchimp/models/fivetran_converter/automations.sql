{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id AS automation_id,
        recipients.list_id,
        recipients.segment_opts.segment_id,
        recipients.segment_opts.segment_text,
        start_time AS started_timestamp,
        create_time AS created_timestamp,
        status,
        settings.title,
        trigger_settings

    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id AS automation_id,
        recipients.list_id,
        recipients.segment_opts.segment_id,
        recipients.segment_opts.segment_text,
        start_time AS started_timestamp,
        create_time AS created_timestamp,
        status,
        settings.title,
        trigger_settings

    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id AS automation_id,
        recipients.list_id,
        recipients.segment_opts.segment_id,
        recipients.segment_opts.segment_text,
        start_time AS started_timestamp,
        create_time AS created_timestamp,
        status,
        settings.title,
        trigger_settings

    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{%endif%}
