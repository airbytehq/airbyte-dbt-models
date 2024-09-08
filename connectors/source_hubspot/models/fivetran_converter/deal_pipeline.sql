SELECT
    NOT active AS is_deal_pipeline_deleted,
    {{ dbt.current_timestamp() }}  AS _fivetran_synced,
    active AS is_active,
    displayOrder AS display_order,
    label AS pipeline_label,
    pipelineId AS deal_pipeline_id,
    createdAt AS deal_pipeline_created_at,
    updatedAt AS deal_pipeline_updated_at
FROM
    {{ source('source_hubspot', 'deal_pipelines') }}
