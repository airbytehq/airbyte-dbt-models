SELECT
    canonical_vid,
    vid_to_merge AS contact_id,
    entity_id,
    first_name AS first_name,
    last_name AS last_name,
    num_properties_moved,
    timestamp AS {{ dbt.type_timestamp() }} AS timestamp_at,
    user_id,
    vid_to_merge,
    {{ dbt.current_timestamp() }}  AS _fivetran_synced,
FROM {{ source('source_hubspot', 'contacts_merged_audit') }}
