WITH TMP AS (
    SELECT
        id AS member_id,
        email_address,
        email_client,
        email_type,
        status,
        list_id,
        timestamp_signup,
        timestamp_opt,
        last_changed,
        ip_opt,
        ip_signup,
        language,
        {{ fivetran_utils.json_extract('location', 'latitude')}} as latitude,
        {{ fivetran_utils.json_extract('location', 'longitude')}} as longitude,
        {{ fivetran_utils.json_extract('location', 'timezone')}} as timezone,
        {{ fivetran_utils.json_extract('location', 'dstoff')}} as dstoff,
        {{ fivetran_utils.json_extract('location', 'gmtoff')}} as gmtoff,
        {{ fivetran_utils.json_extract('location', 'region')}} as region,
        member_rating,
        unique_email_id,
        vip
    FROM
        {{ source('source_mailchimp', 'list_members') }}
)
select * from tmp