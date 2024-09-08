SELECT
    default AS is_deal_pipeline_deleted,
    {{ dbt.current_timestamp() }}  AS _fivetran_synced,
    active AS is_active,
    displayOrder AS display_order,
    label AS pipeline_label,
    CAST(pipelineId AS {{ dbt.type_string() }}) AS deal_pipeline_id,
    CAST(createdAt AS {{ dbt.type_timestamp() }}) AS deal_pipeline_created_at,
    CAST(updatedAt AS {{ dbt.type_timestamp() }}) AS deal_pipeline_updated_at
FROM
    {{ source('source_hubspot', 'deal_pipelines') }}
