SELECT
    'FALSE' AS is_contact_merged_audit_deleted,
    {{ dbt.current_timestamp() }}  AS _fivetran_synced,
    {% if target.type == "postgres" %}
        "user-id" AS id,
    {% elif target.type == "snowflake" %}
        "user_id" AS id,
    {% elif target.type == "bigquery" %}
        `user_id` AS id,
    {% endif %}
    vid_to_merge,
    timestamp AS merged_timestamp,
    {% if target.type == "postgres" %}
        "user-id" AS user_id,
    {% elif target.type == "snowflake" %}
        "user_id" AS user_id,
    {% elif target.type == "bigquery" %}
        `user_id` AS user_id,
    {% endif %}
    first_name AS user_first_name,
    last_name AS user_last_name
FROM
    {{ source('source_hubspot', 'contacts_merged_audit') }}
