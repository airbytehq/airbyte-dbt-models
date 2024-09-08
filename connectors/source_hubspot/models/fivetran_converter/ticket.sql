SELECT
    id AS ticket_id,
    'FALSE' AS is_ticket_deleted,
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    properties_closed_date AS closed_date,
    properties_createdate AS created_date,
    properties_first_agent_reply_date AS first_agent_reply_at,
    properties_hs_pipeline AS ticket_pipeline_id,
    properties_hs_pipeline_stage AS ticket_pipeline_stage_id,
    properties_hs_ticket_category AS ticket_category,
    properties_hs_ticket_priority AS ticket_priority,
    properties_hubspot_owner_id AS owner_id,
    properties_subject AS ticket_subject,
    properties_content AS ticket_content
FROM
    {{ source('source_hubspot', 'tickets') }}
