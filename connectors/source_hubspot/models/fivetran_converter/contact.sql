
    SELECT
        id AS contact_id,
        _fivetran_deleted AS is_contact_deleted,
        properties_hs_calculated_merged_vids AS calculated_merged_vids,
        properties_email AS email,
        properties_company AS contact_company,
        properties_firstname AS first_name,
        properties_lastname AS last_name,
        CAST(properties_createdate AS {{ dbt.type_timestamp() }}) AS created_date,
        properties_jobtitle AS job_title,
        CAST(properties_annualrevenue AS {{ dbt.type_float() }}) AS company_annual_revenue,
        CAST(_fivetran_synced AS {{ dbt.type_timestamp() }}) AS _fivetran_synced

    FROM {{ source('source_hubspot', 'contacts') }}
