{% if target.type == "postgres" %}

SELECT
    {{ dbt.current_timestamp() }} AS fivetran_synced,
    "user-id" AS user_id,
    vid_to_merge AS contact_id,
    entity_id,
    first_name,
    last_name,
    num_properties_moved,
    timestamp,
    "user-id" AS original_user_id,
    vid_to_merge
FROM 
    {{ source('source_hubspot', 'contacts_merged_audit') }}

{% elif target.type == "snowflake" %}

SELECT
    {{ dbt.current_timestamp() }} AS fivetran_synced,
    "user_id" AS user_id,
    vid_to_merge AS contact_id,
    entity_id,
    first_name,
    last_name,
    num_properties_moved,
    timestamp,
    "user_id" AS original_user_id,
    vid_to_merge
FROM 
    {{ source('source_hubspot', 'contacts_merged_audit') }}

{% elif target.type == "bigquery" %}

SELECT
    {{ dbt.current_timestamp() }} AS fivetran_synced,
    `user_id` AS user_id,
    vid_to_merge AS contact_id,
    entity_id,
    first_name,
    last_name,
    num_properties_moved,
    timestamp,
    `user_id` AS original_user_id,
    vid_to_merge
FROM 
    {{ source('source_hubspot', 'contacts_merged_audit') }}

{% endif %}
