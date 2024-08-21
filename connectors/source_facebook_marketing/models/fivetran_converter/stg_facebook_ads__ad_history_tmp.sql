{{ config(enabled=var('ad_reporting__facebook_ads_enabled', True)) }}

with unionned as (
{{
  fivetran_utils.union_data(
    default_database=target.database,
    default_schema='source_facebook_marketing', 
    table_identifier='ads',
    database_variable='facebook_ads_database', 
    schema_variable='facebook_ads_schema', 
    union_schema_variable='facebook_ads_union_schemas',
    union_database_variable='facebook_ads_union_databases'
  )
}}
)

select 
  updated_time
  ,id
  ,name
  ,account_id
  ,adset_id as ad_set_id
  ,campaign_id
  ,{{ fivetran_utils.json_extract('creative', 'id') }} as creative_id
from unionned
