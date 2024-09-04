SELECT
    _airbyte_extracted_at AS _fivetran_synced,
    listId AS list_id,
    name,
    portalId AS portal_id,
    CAST(createdAt AS {{ dbt.type_timestamp() }}) AS created_at,
    CAST(updatedAt AS {{ dbt.type_timestamp() }}) AS updated_at,
    dynamic,
    internal,
    deleteable,
    archived,
    metaData_processing AS metadata_processing,
    metaData_size AS metadata_size,
    metaData_error AS metadata_error,
    metaData_lastProcessingStateChangeAt AS metadata_last_processing_state_change_at,
    metaData_lastSizeChangeAt AS metadata_last_size_change_at
FROM
    {{ source('source_hubspot', 'contact_lists') }}
