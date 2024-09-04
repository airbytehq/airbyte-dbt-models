SELECT
    id AS company_id,
    archived AS is_company_deleted,
    {{ dbt.current_timestamp() }}  AS _fivetran_synced,
    properties_name AS company_name,
    properties_description AS description,
    CAST(properties_createdate AS {{ dbt.type_timestamp() }}) AS created_date,
    properties_industry AS industry,
    properties_address AS street_address,
    properties_address2 AS street_address_2,
    properties_city AS city,
    properties_state AS state,
    properties_country AS country,
    CAST(properties_annualrevenue AS {{ dbt.type_float() }}) AS company_annual_revenue,

FROM {{ source('source_hubspot', 'companies') }}

