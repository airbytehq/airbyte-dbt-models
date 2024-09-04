SELECT
    _airbyte_extracted_at,
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
    CAST(metaData_lastProcessingStateChangeAt AS {{ dbt.type_timestamp() }}) AS metadata_last_processing_state_change_at,
    CAST(metaData_lastSizeChangeAt AS {{ dbt.type_timestamp() }}) AS metadata_last_size_change_at
FROM
    {{ source('source_hubspot', 'contact_lists') }}
