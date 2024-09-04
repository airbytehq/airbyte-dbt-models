WITH TMP AS (
    SELECT
        campaign_id,
        email_id AS member_id,
        list_id,
        reason,
        timestamp
    FROM
        {{ source('source_mailchimp', 'unsubscribes') }}
)

SELECT * FROM TMP