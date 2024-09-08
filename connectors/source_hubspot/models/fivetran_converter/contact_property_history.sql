SELECT
    {{ dbt.current_timestamp() }}  AS _fivetran_synced,
    vid AS contact_id,
    properties_firstname AS field_name,
    {% if target.type == "postgres" %}
        "source-id" AS change_source,
    {% elif target.type == "snowflake" %}
        "source-id" AS change_source,
    {% elif target.type == "bigquery" %}
        `source_id` AS change_source,
    {% endif %}
    properties_hs_created_by_user_id AS change_source_id,
    timestamp AS change_timestamp,
    value AS new_value
FROM
    {{ source('source_hubspot', 'contacts_property_history') }}
