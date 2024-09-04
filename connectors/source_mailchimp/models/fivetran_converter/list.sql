WITH TMP AS (
    SELECT
        id,
        date_created,
        name,
        list_rating,
        beamer_address,
        {{ fivetran_utils.json_extract('contact', 'addr1')}} as contact_address_1,
        {{ fivetran_utils.json_extract('contact', 'addr2')}} as contact_address_2,
        {{ fivetran_utils.json_extract('contact', 'city')}} as contact_city,
        {{ fivetran_utils.json_extract('contact', 'company')}} as contact_company,
        {{ fivetran_utils.json_extract('contact', 'country')}} as contact_country,
        {{ fivetran_utils.json_extract('contact', 'state')}} as contact_state,
        {{ fivetran_utils.json_extract('contact', 'zip')}} as contact_zip,
        {{ fivetran_utils.json_extract('campaign_defaults', 'from_email')}} as default_from_email,
        {{ fivetran_utils.json_extract('campaign_defaults', 'from_name')}} as default_from_name,
        {{ fivetran_utils.json_extract('campaign_defaults', 'language')}} as default_language,
        {{ fivetran_utils.json_extract('campaign_defaults', 'subject')}} as default_subject,
        email_type_option,
        notify_on_subscribe,
        notify_on_unsubscribe,
        permission_reminder,
        subscribe_url_long,
        subscribe_url_short,
        use_archive_bar,
        visibility
    FROM
        {{ source('source_mailchimp', 'lists') }}
)

SELECT * FROM TMP