{{ config(enabled=var('ad_reporting__facebook_ads_enabled', True)) }}

with unionned as (
{{
  fivetran_utils.union_data(
    default_database=target.database,
    default_schema='source_facebook_marketing',
    table_identifier='campaigns', 
    database_variable='facebook_ads_database', 
    schema_variable='facebook_ads_schema', 
    union_schema_variable='facebook_ads_union_schemas',
    union_database_variable='facebook_ads_union_databases'
  )
}}
)

select 
  updated_time
  ,created_time
  ,account_id
  ,id
  ,name
  ,start_time
  ,stop_time
  ,status
  ,daily_budget
  ,lifetime_budget
  ,budget_remaining

  {% if var('facebook_ads_union_databases', none) or var('facebook_ads_union_schemas', none) %}
  ,_dbt_source_relation
  {% endif %}

from unionned
