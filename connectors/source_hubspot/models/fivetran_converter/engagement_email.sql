SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    'FALSE' AS _fivetran_deleted,
    'EMAIL' AS engagement_type,
    id AS engagement_id,
    createdAt AS created_timestamp,
    properties_hs_timestamp AS occurred_timestamp,
    properties_hubspot_owner_id AS owner_id,
    properties_hubspot_team_id AS team_id,
    properties_hs_all_owner_ids AS all_owner_ids,
    properties_hs_all_team_ids AS all_team_ids,
    properties_hs_email_subject AS email_subject,
    properties_hs_email_text AS email_text,
    properties_hs_lastmodifieddate AS lastmodifieddate,
    properties_hs_modified_by AS modified_by
FROM
    {{ source('source_hubspot', 'engagements_emails') }}
