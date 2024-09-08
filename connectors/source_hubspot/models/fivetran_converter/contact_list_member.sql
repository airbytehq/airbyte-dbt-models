SELECT
    'FALSE' AS is_contact_list_member_deleted,
    {{ dbt.current_timestamp() }} AS _fivetran_synced
    NULL AS contact_id,
    static_list_id AS contact_list_id
FROM
    {{ source('source_hubspot', 'contacts_list_memberships') }}
