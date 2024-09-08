SELECT
    {{ dbt.current_timestamp() }}  AS _fivetran_synced,
    source_id AS contact_id,
    name AS field_name,
    source AS change_source,
    source_id AS change_source_id,
    CAST(timestamp AS {{ dbt.type_timestamp() }}) AS change_timestamp,
    value AS new_value
FROM
    {{ source('source_hubspot', 'contacts_property_history') }}
