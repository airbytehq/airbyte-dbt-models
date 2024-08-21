{{ config(enabled=var('ad_reporting__facebook_ads_enabled', True)) }}

with unionned as (
{{
  fivetran_utils.union_data(
    default_database=target.database,
    default_schema='source_facebook_marketing',
    table_identifier='ads_insights', 
    database_variable='facebook_ads_database', 
    schema_variable='facebook_ads_schema', 
    union_schema_variable='facebook_ads_union_schemas',
    union_database_variable='facebook_ads_union_databases'
  )
}}
)

select 
  ad_id
  ,ad_name
  ,adset_name
  ,date_start as date
  ,account_id
  ,impressions
  ,inline_link_clicks
  ,spend
  ,reach
  ,frequency

  {% for field in var(facebook_ads__basic_ad_passthrough_metrics, []) %}
    ,{{ field.alias|default(field.name)|lower }}
  {% endfor %}

from unionned
