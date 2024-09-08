SELECT
    id AS contact_id,
    properties_hs_is_contact AS is_contact_deleted,
    properties_hs_calculated_merged_vids AS calculated_merged_vids,
    properties_email AS email,
    properties_company AS contact_company,
    properties_firstname AS first_name,
    properties_lastname AS last_name,
    properties_createdate AS created_date,
    properties_jobtitle AS job_title,
    properties_annualrevenue AS company_annual_revenue,
    {{ dbt.current_timestamp() }}  AS _fivetran_synced
FROM 
    {{ source('source_hubspot', 'contacts') }}
