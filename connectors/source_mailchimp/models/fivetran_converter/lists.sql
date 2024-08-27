{% if target.type == "postgres" %}

WITH TMP AS (
    SELECT
        id AS list_id,
        date_created,
        name,
        list_rating,
        beamer_address,
        contact->>'addr1' AS contact_address_1,
        contact->>'addr2' AS contact_address_2,
        contact->>'city' AS contact_city,
        contact->>'company' AS contact_company,
        contact->>'country' AS contact_country,
        contact->>'state' AS contact_state,
        contact->>'zip' AS contact_zip,
        campaign_defaults->>'from_email' AS default_from_email,
        campaign_defaults->>'from_name' AS default_from_name,
        campaign_defaults->>'subject' AS default_subject,
        email_type_option,
        notify_on_subscribe,
        notify_on_unsubscribe,
        permission_reminder,
        subscribe_url_long,
        subscribe_url_short,
        use_archive_bar,
        visibility
        -- Note: default_language column is skipped as it is not present in the Airbyte DB
    FROM
        {{ source('source_mailchimp', 'lists') }}
)

SELECT * FROM TMP

{% elif target.type == "bigquery" %}

WITH TMP AS (
    SELECT
        id AS list_id,
        date_created,
        name,
        list_rating,
        beamer_address,
        JSON_EXTRACT_SCALAR(contact, '$.addr1') AS contact_address_1,
        JSON_EXTRACT_SCALAR(contact, '$.addr2') AS contact_address_2,
        JSON_EXTRACT_SCALAR(contact, '$.city') AS contact_city,
        JSON_EXTRACT_SCALAR(contact, '$.company') AS contact_company,
        JSON_EXTRACT_SCALAR(contact, '$.country') AS contact_country,
        JSON_EXTRACT_SCALAR(contact, '$.state') AS contact_state,
        JSON_EXTRACT_SCALAR(contact, '$.zip') AS contact_zip,
        JSON_EXTRACT_SCALAR(campaign_defaults, '$.from_email') AS default_from_email,
        JSON_EXTRACT_SCALAR(campaign_defaults, '$.from_name') AS default_from_name,
        JSON_EXTRACT_SCALAR(campaign_defaults, '$.subject') AS default_subject,
        email_type_option,
        notify_on_subscribe,
        notify_on_unsubscribe,
        permission_reminder,
        subscribe_url_long,
        subscribe_url_short,
        use_archive_bar,
        visibility
        -- Note: default_language column is skipped as it is not present in the Airbyte DB
    FROM
        {{ source('source_mailchimp', 'lists') }}
)

SELECT * FROM TMP

{% elif target.type == "snowflake" %}

WITH TMP AS (
    SELECT
        id AS list_id,
        date_created,
        name,
        list_rating,
        beamer_address,
        contact:addr1::string AS contact_address_1,
        contact:addr2::string AS contact_address_2,
        contact:city::string AS contact_city,
        contact:company::string AS contact_company,
        contact:country::string AS contact_country,
        contact:state::string AS contact_state,
        contact:zip::string AS contact_zip,
        campaign_defaults:from_email::string AS default_from_email,
        campaign_defaults:from_name::string AS default_from_name,
        campaign_defaults:subject::string AS default_subject,
        email_type_option,
        notify_on_subscribe,
        notify_on_unsubscribe,
        permission_reminder,
        subscribe_url_long,
        subscribe_url_short,
        use_archive_bar,
        visibility
        -- Note: default_language column is skipped as it is not present in the Airbyte DB
    FROM
        {{ source('source_mailchimp', 'lists') }}
)

SELECT * FROM TMP

{%endif%}
