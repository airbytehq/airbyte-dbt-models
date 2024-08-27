{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id AS automation_email_id,
        id AS automation_id,
        create_time AS created_timestamp,
        start_time AS started_timestamp,
        send_time AS send_timestamp,

        settings.from_name AS from_name,
        settings.reply_to AS reply_to,
        status,
        settings.subject_line AS subject_line,
        settings.title AS title,
        settings.to_name AS to_name,
        archive_url,

        settings.authenticate AS authenticate,
        settings.auto_footer AS auto_footer,
        tracking.auto_tweet AS auto_tweet,
        tracking.clicktale AS clicktale,
        content_type,
        tracking.google_analytics AS google_analytics,
        settings.folder_id AS folder_id,
        settings.template_id AS template_id,
        settings.timewarp AS timewarp,
        tracking.ecomm360 AS track_ecomm_360,
        tracking.goals AS track_goals,
        tracking.html_clicks AS track_html_clicks,
        tracking.opens AS track_opens,
        tracking.text_clicks AS track_text_clicks,

        -- The following columns are not present in the Airbyte schema:
        -- delay_action, delay_action_description, delay_amount,
        -- delay_direction, delay_full_description, delay_type, drag_and_drop,
        -- fb_comments, inline_css, position, use_conversation

    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id AS automation_email_id,
        id AS automation_id,
        create_time AS created_timestamp,
        start_time AS started_timestamp,
        send_time AS send_timestamp,

        settings.from_name AS from_name,
        settings.reply_to AS reply_to,
        status,
        settings.subject_line AS subject_line,
        settings.title AS title,
        settings.to_name AS to_name,
        archive_url,

        settings.authenticate AS authenticate,
        settings.auto_footer AS auto_footer,
        tracking.auto_tweet AS auto_tweet,
        tracking.clicktale AS clicktale,
        content_type,
        tracking.google_analytics AS google_analytics,
        settings.folder_id AS folder_id,
        settings.template_id AS template_id,
        settings.timewarp AS timewarp,
        tracking.ecomm360 AS track_ecomm_360,
        tracking.goals AS track_goals,
        tracking.html_clicks AS track_html_clicks,
        tracking.opens AS track_opens,
        tracking.text_clicks AS track_text_clicks

    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id AS automation_email_id,
        id AS automation_id,
        create_time AS created_timestamp,
        start_time AS started_timestamp,
        send_time AS send_timestamp,

        settings.from_name AS from_name,
        settings.reply_to AS reply_to,
        status,
        settings.subject_line AS subject_line,
        settings.title AS title,
        settings.to_name AS to_name,
        archive_url,

        settings.authenticate AS authenticate,
        settings.auto_footer AS auto_footer,
        tracking.auto_tweet AS auto_tweet,
        tracking.clicktale AS clicktale,
        content_type,
        tracking.google_analytics AS google_analytics,
        settings.folder_id AS folder_id,
        settings.template_id AS template_id,
        settings.timewarp AS timewarp,
        tracking.ecomm360 AS track_ecomm_360,
        tracking.goals AS track_goals,
        tracking.html_clicks AS track_html_clicks,
        tracking.opens AS track_opens,
        tracking.text_clicks AS track_text_clicks

    FROM
        {{ source('source_mailchimp', 'automations') }}
)

SELECT * FROM TMP

{%endif%}
