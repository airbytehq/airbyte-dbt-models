SELECT
    {{ dbt.current_timestamp() }}  AS _fivetran_synced,
    vid AS contact_id,
    properties_firstname AS field_name,
    "source-id" AS change_source,
    properties_hs_created_by_user_id AS change_source_id,
    CAST(timestamp AS {{ dbt.type_timestamp() }}) AS change_timestamp,
    value AS new_value
FROM
    {{ source('source_hubspot', 'contacts_property_history') }}
