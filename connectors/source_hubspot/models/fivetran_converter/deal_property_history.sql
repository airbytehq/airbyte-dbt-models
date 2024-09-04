SELECT
    {{ dbt.current_timestamp() }}  AS _fivetran_synced,
    dealId AS deal_id,
    property AS field_name,
    sourceType AS change_source,
    sourceId AS change_source_id,
    CAST(timestamp AS {{ dbt.type_timestamp() }}) AS change_timestamp,
    value AS new_value
FROM
    {{ source('source_hubspot', 'deals_property_history') }}
