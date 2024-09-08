SELECT
    "user-id" AS user_id,
    vid_to_merge AS contact_id,
    entity_id,
    first_name,
    last_name,
    num_properties_moved,
    {{ dbt.type_timestamp() }} AS timestamp_at,
    "user-id" AS user_id,
    vid_to_merge,
    {{ dbt.current_timestamp() }} AS _fivetran_synced
FROM 
    {{ source('source_hubspot', 'contacts_merged_audit') }}
