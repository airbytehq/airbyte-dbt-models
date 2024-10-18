SELECT
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    'FALSE' AS _fivetran_deleted,
    id AS engagement_id,
    'CALL' AS engagement_type,
    createdAt AS created_timestamp,
    properties_hs_timestamp AS occurred_timestamp,
    properties_hubspot_owner_id AS owner_id,
    properties_hubspot_team_id AS team_id
FROM
    {{ source('source_hubspot', 'engagements_calls') }}
