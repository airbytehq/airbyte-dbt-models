SELECT
    'FALSE' AS is_contact_merged_audit_deleted,
    {{ dbt.current_timestamp() }}  AS _fivetran_synced,
    user-id AS id,
    vid_to_merge,
    CAST(timestamp AS {{ dbt.type_timestamp() }}) AS merged_timestamp,
    user_id,
    first_name AS user_first_name,
    last_name AS user_last_name
FROM
    {{ source('source_hubspot', 'contacts_merged_audit') }}
