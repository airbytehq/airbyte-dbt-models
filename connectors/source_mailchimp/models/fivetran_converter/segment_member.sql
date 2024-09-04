WITH TMP AS (
    SELECT
        segment_id,
        id AS member_id,
        list_id
    FROM
        {{ source('source_mailchimp', 'segment_members') }}
)

SELECT * FROM TMP