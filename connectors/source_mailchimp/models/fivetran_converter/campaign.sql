WITH TMP AS (
    SELECT
        id,
        null as segment_id,
        create_time,
        send_time,
        {{ fivetran_utils.json_extract('recipients', 'list_id')}} as list_id,
        {{ fivetran_utils.json_extract('settings', 'reply_to')}} as reply_to,
        type,
        {{ fivetran_utils.json_extract('settings', 'title')}} as title,
        archive_url,
        {{ fivetran_utils.json_extract('settings', 'authenticate')}} as authenticate,
        {{ fivetran_utils.json_extract('settings', 'auto_footer')}} as auto_footer,
        {{ fivetran_utils.json_extract('settings', 'auto_tweet')}} as auto_tweet,
        null as clicktale,
        content_type,
        {{ fivetran_utils.json_extract('settings', 'drag_and_drop')}} as drag_and_drop,
        {{ fivetran_utils.json_extract('settings', 'fb_comments')}} as fb_comments,
        null as folder_id,
        {{ fivetran_utils.json_extract('settings', 'from_name')}} as from_name,
        null as google_analytics,
        {{ fivetran_utils.json_extract('settings', 'inline_css')}} as inline_css,
        long_archive_url,
        status,
        {{ fivetran_utils.json_extract('settings', 'subject_line')}} as subject_line,
        {{ fivetran_utils.json_extract('settings', 'template_id')}} as template_id,
        null as test_size,
        {{ fivetran_utils.json_extract('settings', 'timewarp')}} as timewarp,
        {{ fivetran_utils.json_extract('settings', 'to_name')}} as to_name,
        {{ fivetran_utils.json_extract('tracking', 'ecomm360')}} as tracking_ecomm360,
        {{ fivetran_utils.json_extract('tracking', 'goal_tracking')}} as tracking_goals,
        {{ fivetran_utils.json_extract('tracking', 'html_clicks')}} as tracking_html_clicks,
        {{ fivetran_utils.json_extract('tracking', 'opens')}} as track_opens,
        {{ fivetran_utils.json_extract('tracking', 'text_clicks')}} as track_text_clicks,
        {{ fivetran_utils.json_extract('settings', 'use_conversation')}} as use_conversation,
        {{ fivetran_utils.json_extract('variate_settings', 'wait_time')}} as wait_time,
        {{ fivetran_utils.json_extract('variate_settings', 'winner_criteria')}} as winner_criteria,
        {{ fivetran_utils.json_extract('variate_settings', 'winning_campaign_id')}} as winning_campaign_id,
        {{ fivetran_utils.json_extract('variate_settings', 'winning_combination_id')}} as winning_combination_id
    FROM
        {{ source('source_mailchimp', 'campaigns') }}
)

SELECT * FROM TMP