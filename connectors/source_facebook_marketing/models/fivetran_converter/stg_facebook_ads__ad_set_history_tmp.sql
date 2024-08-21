{{ config(enabled=var('ad_reporting__facebook_ads_enabled', True)) }}

with unionned as (
{{
  fivetran_utils.union_data(
    default_database=target.database,
    default_schema='source_facebook_marketing', 
    table_identifier='ad_sets',
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
  ,campaign_id
  ,start_time
  ,end_time
  ,bid_strategy
  ,daily_budget
  ,budget_remaining
  ,effective_status as status
from unionned
