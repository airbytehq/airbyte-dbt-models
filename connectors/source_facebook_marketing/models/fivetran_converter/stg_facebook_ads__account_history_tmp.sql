{{ config(enabled=var('ad_reporting__facebook_ads_enabled', True)) }}

with unionned as (
{{
  fivetran_utils.union_data(
    default_database=target.database,
    default_schema='source_facebook_marketing',
    table_identifier='ad_account', 
    database_variable='facebook_ads_database', 
    schema_variable='facebook_ads_schema', 
    union_schema_variable='facebook_ads_union_schemas',
    union_database_variable='facebook_ads_union_databases'
  )
}}
)

select 
  {{ dbt.split_part(string_text='id', delimiter_text="'_'", part_number=2) }} as id
  ,_airbyte_extracted_at as _fivetran_synced
  ,name
  ,account_status
  ,business_country_code
  ,created_time
  ,currency
  ,timezone_name
from unionned
