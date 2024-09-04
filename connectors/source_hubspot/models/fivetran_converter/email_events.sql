SELECT
    CAST(_fivetran_synced AS {{ dbt.type_timestamp() }}) AS _fivetran_synced,
    appId AS app_id,
    CAST(caused_by.created AS {{ dbt.type_timestamp() }}) AS caused_timestamp,
    caused_by.id AS caused_by_event_id,
    CAST(created AS {{ dbt.type_timestamp() }}) AS created_timestamp,
    emailCampaignId AS email_campaign_id,
    filteredEvent AS is_filtered_event,
    id AS event_id,
    CAST(obsoletedBy.created AS {{ dbt.type_timestamp() }}) AS obsoleted_timestamp,
    obsoletedBy.id AS obsoleted_by_event_id,
    portalId AS portal_id,
    recipient AS recipient_email_address,
    CAST(sentBy.created AS {{ dbt.type_timestamp() }}) AS sent_timestamp,
    sentBy.id AS sent_by_event_id,
    type AS event_type
FROM
    {{ source('source_hubspot', 'email_events') }}
