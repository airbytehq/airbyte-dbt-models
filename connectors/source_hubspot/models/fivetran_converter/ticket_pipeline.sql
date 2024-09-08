SELECT
    CAST(id AS {{ dbt.type_int() }}) AS ticket_pipeline_id,
    'FALSE' AS is_ticket_pipeline_deleted,
    {{ dbt.current_timestamp() }} AS _fivetran_synced,
    NOT archived AS is_active,
    displayOrder AS display_order,
    label AS pipeline_label,
    object_type_id,
    createdAt AS ticket_pipeline_created_at,
    updatedAt AS ticket_pipeline_updated_at
FROM {{ source('source_hubspot', 'ticket_pipelines') }}
