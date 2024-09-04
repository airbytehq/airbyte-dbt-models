WITH TMP AS (
    SELECT
        campaign_id,
        list_id,
        email_id as member_id,
        null as combination_id
    FROM
        {{ source('source_mailchimp', 'email_activity') }}
)

select * from tmp