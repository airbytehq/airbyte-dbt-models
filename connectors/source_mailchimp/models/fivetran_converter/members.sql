{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id AS member_id,
        email_address,
        email_client,
        email_type,
        status,
        list_id,
        timestamp_signup AS signup_timestamp,
        timestamp_opt AS opt_in_timestamp,
        last_changed AS last_changed_timestamp,
        ip_opt AS opt_in_ip_address,
        ip_signup AS signup_ip_address,
        language,
        location->>'latitude' AS latitude,
        location->>'longitude' AS longitude,
        member_rating,
        location->>'timezone' AS timezone,
        unique_email_id,
        vip
        -- Note: 'country_code', 'dstoff', 'gmtoff' columns are skipped as they are not present in the Airbyte DB
    FROM
        {{ source('source_mailchimp', 'list_members') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id AS member_id,
        email_address,
        email_client,
        email_type,
        status,
        list_id,
        timestamp_signup AS signup_timestamp,
        timestamp_opt AS opt_in_timestamp,
        last_changed AS last_changed_timestamp,
        ip_opt AS opt_in_ip_address,
        ip_signup AS signup_ip_address,
        language,
        JSON_EXTRACT_SCALAR(location, '$.latitude') AS latitude,
        JSON_EXTRACT_SCALAR(location, '$.longitude') AS longitude,
        member_rating,
        JSON_EXTRACT_SCALAR(location, '$.timezone') AS timezone,
        unique_email_id,
        vip
        -- Note: 'country_code', 'dstoff', 'gmtoff' columns are skipped as they are not present in the Airbyte DB
    FROM
        {{ source('source_mailchimp', 'list_members') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id AS member_id,
        email_address,
        email_client,
        email_type,
        status,
        list_id,
        timestamp_signup AS signup_timestamp,
        timestamp_opt AS opt_in_timestamp,
        last_changed AS last_changed_timestamp,
        ip_opt AS opt_in_ip_address,
        ip_signup AS signup_ip_address,
        language,
        location:latitude::string AS latitude,
        location:longitude::string AS longitude,
        member_rating,
        location:timezone::string AS timezone,
        unique_email_id,
        vip
        -- Note: 'country_code', 'dstoff', 'gmtoff' columns are skipped as they are not present in the Airbyte DB
    FROM
        {{ source('source_mailchimp', 'list_members') }}
)

SELECT * FROM TMP

{%endif%}
