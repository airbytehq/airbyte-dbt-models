SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    'FALSE' AS _fivetran_deleted,
    properties_hs_note_body AS note,
    'note' AS engagement_type,
    id AS engagement_id,
    properties_hs_createdate AS created_timestamp,
    properties_hs_timestamp AS occurred_timestamp,
    properties_hs_created_by AS owner_id,
    properties_hubspot_team_id  AS team_id,
    properties_hs_body_preview AS body_preview,
    properties_hs_lastmodifieddate AS lastmodifieddate,
    properties_hs_note_body AS note_body
FROM
    {{ source('source_hubspot', 'engagements_notes') }}
