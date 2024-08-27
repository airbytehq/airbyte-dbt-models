{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id AS campaign_id,
        recipients.segment_opts.segment_id AS segment_id,
        create_time AS create_timestamp,
        send_time AS send_timestamp,
        recipients.list_id,
        settings.reply_to AS reply_to_email,
        type AS campaign_type,
        settings.title AS title,
        archive_url,
        settings.authenticate,
        settings.auto_footer,
        tracking.auto_tweet,
        tracking.clicktale,
        content_type,
        settings.folder_id,
        settings.from_name,
        tracking.google_analytics,
        long_archive_url,
        status,
        settings.subject_line,
        settings.template_id,
        settings.timewarp,
        settings.to_name,
        tracking.ecomm360,
        tracking.goals,
        tracking.html_clicks,
        tracking.opens,
        tracking.text_clicks,
        variate_settings.winner_criteria
        -- Fields not present: drag_and_drop, fb_comments, inline_css, test_size, use_conversation, wait_time, winning_campaign_id, winning_combination_id
    FROM
        {{ source('source_mailchimp', 'campaigns') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id AS campaign_id,
        recipients.segment_opts.segment_id AS segment_id,
        create_time AS create_timestamp,
        send_time AS send_timestamp,
        recipients.list_id,
        settings.reply_to AS reply_to_email,
        type AS campaign_type,
        settings.title AS title,
        archive_url,
        settings.authenticate,
        settings.auto_footer,
        tracking.auto_tweet,
        tracking.clicktale,
        content_type,
        settings.folder_id,
        settings.from_name,
        tracking.google_analytics,
        long_archive_url,
        status,
        settings.subject_line,
        settings.template_id,
        settings.timewarp,
        settings.to_name,
        tracking.ecomm360,
        tracking.goals,
        tracking.html_clicks,
        tracking.opens,
        tracking.text_clicks,
        variate_settings.winner_criteria
        -- Fields not present: drag_and_drop, fb_comments, inline_css, test_size, use_conversation, wait_time, winning_campaign_id, winning_combination_id
    FROM
        {{ source('source_mailchimp', 'campaigns') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id AS campaign_id,
        recipients.segment_opts.segment_id AS segment_id,
        create_time AS create_timestamp,
        send_time AS send_timestamp,
        recipients.list_id,
        settings.reply_to AS reply_to_email,
        type AS campaign_type,
        settings.title AS title,
        archive_url,
        settings.authenticate,
        settings.auto_footer,
        tracking.auto_tweet,
        tracking.clicktale,
        content_type,
        settings.folder_id,
        settings.from_name,
        tracking.google_analytics,
        long_archive_url,
        status,
        settings.subject_line,
        settings.template_id,
        settings.timewarp,
        settings.to_name,
        tracking.ecomm360,
        tracking.goals,
        tracking.html_clicks,
        tracking.opens,
        tracking.text_clicks,
        variate_settings.winner_criteria
        -- Fields not present: drag_and_drop, fb_comments, inline_css, test_size, use_conversation, wait_time, winning_campaign_id, winning_combination_id
    FROM
        {{ source('source_mailchimp', 'campaigns') }}
)

SELECT * FROM TMP

{%endif%}
