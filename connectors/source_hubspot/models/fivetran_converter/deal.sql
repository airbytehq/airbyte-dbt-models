SELECT
    deal_id,
    properties_dealname AS deal_name,
    CAST(properties_closedate AS {{ dbt.type_timestamp() }}) AS closed_date,
    CAST(properties_createdate AS {{ dbt.type_timestamp() }}) AS created_date,
    CAST(_fivetran_synced AS {{ dbt.type_timestamp() }}) AS _fivetran_synced,
    CAST(properties_pipeline AS {{ dbt.type_string() }}) AS deal_pipeline_id,
    CAST(properties_dealstage AS {{ dbt.type_string() }}) AS deal_pipeline_stage_id,
    properties_hubspot_owner_id AS owner_id,
    CAST(properties_hs_object_id AS {{ dbt.type_string() }}) AS portal_id,
    properties_description AS description,
    CAST(properties_amount AS {{ dbt.type_float() }}) AS amount,
    CAST(properties_hs_is_closed AS {{ dbt.type_boolean() }}) AS is_closed,
    CAST(properties_hs_is_closed_won AS {{ dbt.type_boolean() }}) AS is_won,
    CAST(archived AS {{ dbt.type_boolean() }}) AS is_deal_deleted,
    CAST(properties_hs_created_by_user_id AS {{ dbt.type_string() }}) AS created_by_user_id,
    CAST(properties_hs_lastmodifieddate AS {{ dbt.type_timestamp() }}) AS last_modified_date,
    CAST(properties_hs_updated_by_user_id AS {{ dbt.type_string() }}) AS updated_by_user_id

FROM {{ source('source_hubspot', 'deals') }}
