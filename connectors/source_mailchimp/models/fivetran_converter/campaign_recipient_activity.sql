WITH TMP AS (
    SELECT
        action,
        campaign_id,
        list_id,
        email_id as member_id,
        timestamp,
        ip,
        url,
        null as combination_id,
        null as bounce_type
    FROM
        {{ source('source_mailchimp', 'email_activity') }}
)

select * from tmp