{% if target.type == "postgres" %}

SELECT
    {{ dbt.current_timestamp() }} AS fivetran_synced,
    "user-id" AS user_id,
    vid_to_merge AS contact_id,
    entity_id,
    first_name,
    last_name,
    num_properties_moved,
    timestamp_at,
    "user-id" AS original_user_id,
    vid_to_merge
FROM 
    {{ source('source_hubspot', 'contacts_merged_audit') }}

{% elif target.type == "snowflake" %}

SELECT
    {{ dbt.current_timestamp() }} AS fivetran_synced,
    `"user-id"`::STRING AS user_id,
    vid_to_merge AS contact_id,
    entity_id,
    first_name,
    last_name,
    num_properties_moved,
    timestamp_at,
    `"user-id"`::STRING AS original_user_id,
    vid_to_merge
FROM 
    {{ source('source_hubspot', 'contacts_merged_audit') }}

{% elif target.type == "bigquery" %}

SELECT
    {{ dbt.current_timestamp() }} AS fivetran_synced,
    `user-id` AS user_id,
    vid_to_merge AS contact_id,
    entity_id,
    first_name,
    last_name,
    num_properties_moved,
    timestamp_at,
    `user-id` AS original_user_id,
    vid_to_merge
FROM 
    {{ source('source_hubspot', 'contacts_merged_audit') }}

{% endif %}
