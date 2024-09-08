{% if target.type == "postgres" %}

SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    "appId" AS app_id,
    causedBy->>'created' AS caused_timestamp,
    causedBy->>'id' AS caused_by_event_id,
    created AS created_timestamp,
    "emailCampaignId" AS email_campaign_id,
    "filteredEvent" AS is_filtered_event,
    id AS event_id,
    obsoleted_by->>'created' AS obsoleted_timestamp,
    obsoleted_by->>'id' AS obsoleted_by_event_id,
    "portalId" AS portal_id,
    recipient AS recipient_email_address,
    sent_by->>'created' AS sent_timestamp,
    sent_by->>'id' AS sent_by_event_id,
    type AS event_type
FROM
    {{ source('source_hubspot', 'email_events') }}

{% elif target.type == "snowflake" %}

SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    appId AS app_id,
    causedBy:created AS caused_timestamp,
    causedBy:id AS caused_by_event_id,
    created AS created_timestamp,
    emailCampaignId AS email_campaign_id,
    filteredEvent AS is_filtered_event,
    id AS event_id,
    obsoletedBy:created AS obsoleted_timestamp,
    obsoletedBy:id AS obsoleted_by_event_id,
    portalId AS portal_id,
    recipient AS recipient_email_address,
    sentBy:created AS sent_timestamp,
    sentBy:id AS sent_by_event_id,
    type AS event_type
FROM
    {{ source('source_hubspot', 'email_events') }}

{% elif target.type == "bigquery" %}

SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    appId AS app_id,
    JSON_EXTRACT_SCALAR(causedBy, '$.created') AS caused_timestamp,
    JSON_EXTRACT_SCALAR(causedBy, '$.id') AS caused_by_event_id,
    created AS created_timestamp,
    emailCampaignId AS email_campaign_id,
    filteredEvent AS is_filtered_event,
    id AS event_id,
    JSON_EXTRACT_SCALAR(obsoletedBy, '$.created') AS obsoleted_timestamp,
    JSON_EXTRACT_SCALAR(obsoletedBy, '$.id') AS obsoleted_by_event_id,
    portalId AS portal_id,
    recipient AS recipient_email_address,
    JSON_EXTRACT_SCALAR(sentBy, '$.created') AS sent_timestamp,
    JSON_EXTRACT_SCALAR(sentBy, '$.id') AS sent_by_event_id,
    type AS event_type
FROM
    {{ source('source_hubspot', 'email_events') }}

{% endif %}