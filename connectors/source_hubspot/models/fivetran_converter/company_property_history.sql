SELECT
    CAST(_fivetran_synced AS {{ dbt.type_timestamp() }}) AS _fivetran_synced,
    companyId AS company_id,
    property AS field_name,
    sourceType AS change_source,
    sourceId AS change_source_id,
    CAST(timestamp AS {{ dbt.type_timestamp() }}) AS change_timestamp,
    value AS new_value,
    updatedByUserId AS updated_by_user_id,
    archived AS is_archived
FROM
    {{ source('source_hubspot', 'companies_property_history') }}
