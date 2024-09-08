{% if target.type == "postgres" %}

SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    "appId" AS app_id,
    CAST(causedBy->>'created' AS {{ dbt.type_timestamp() }}) AS caused_timestamp,
    causedBy->>'id' AS caused_by_event_id,
    CAST(created AS {{ dbt.type_timestamp() }}) AS created_timestamp,
    "emailCampaignId" AS email_campaign_id,
    "filteredEvent" AS is_filtered_event,
    id AS event_id,
    CAST(obsoleted_by->>'created' AS {{ dbt.type_timestamp() }}) AS obsoleted_timestamp,
    obsoleted_by->>'id' AS obsoleted_by_event_id,
    "portalId" AS portal_id,
    recipient AS recipient_email_address,
    CAST(sent_by->>'created' AS {{ dbt.type_timestamp() }}) AS sent_timestamp,
    sent_by->>'id' AS sent_by_event_id,
    type AS event_type
FROM
    {{ source('source_hubspot', 'email_events') }}

{% elif target.type == "snowflake" %}

SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    appId AS app_id,
    CAST(causedBy:created AS {{ dbt.type_timestamp() }}) AS caused_timestamp,
    causedBy:id AS caused_by_event_id,
    CAST(created AS {{ dbt.type_timestamp() }}) AS created_timestamp,
    emailCampaignId AS email_campaign_id,
    filteredEvent AS is_filtered_event,
    id AS event_id,
    CAST(obsoletedBy:created AS {{ dbt.type_timestamp() }}) AS obsoleted_timestamp,
    obsoletedBy:id AS obsoleted_by_event_id,
    portalId AS portal_id,
    recipient AS recipient_email_address,
    CAST(sentBy:created AS {{ dbt.type_timestamp() }}) AS sent_timestamp,
    sentBy:id AS sent_by_event_id,
    type AS event_type
FROM
    {{ source('source_hubspot', 'email_events') }}

{% elif target.type == "bigquery" %}

SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    appId AS app_id,
    CAST(JSON_EXTRACT_SCALAR(causedBy, '$.created') AS {{ dbt.type_timestamp() }}) AS caused_timestamp,
    JSON_EXTRACT_SCALAR(causedBy, '$.id') AS caused_by_event_id,
    CAST(created AS {{ dbt.type_timestamp() }}) AS created_timestamp,
    emailCampaignId AS email_campaign_id,
    filteredEvent AS is_filtered_event,
    id AS event_id,
    CAST(JSON_EXTRACT_SCALAR(obsoletedBy, '$.created') AS {{ dbt.type_timestamp() }}) AS obsoleted_timestamp,
    JSON_EXTRACT_SCALAR(obsoletedBy, '$.id') AS obsoleted_by_event_id,
    portalId AS portal_id,
    recipient AS recipient_email_address,
    CAST(JSON_EXTRACT_SCALAR(sentBy, '$.created') AS {{ dbt.type_timestamp() }}) AS sent_timestamp,
    JSON_EXTRACT_SCALAR(sentBy, '$.id') AS sent_by_event_id,
    type AS event_type
FROM
    {{ source('source_hubspot', 'email_events') }}

{% endif %}