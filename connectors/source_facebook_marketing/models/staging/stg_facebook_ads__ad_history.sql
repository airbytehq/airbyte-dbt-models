{% set sources_dict = var('airbyte')['facebook_ads']['sources']['ads'] %}
{% set sources = convert_to_relations(sources_dict) %}

with unionned as (
{{
  dbt_utils.union_relations(
    relations=sources
  )
}}
)

,final as (
  select
    _dbt_source_relation as source_relation
    ,updated_time as updated_at
    ,cast(id as {{ dbt.type_bigint() }}) as ad_id 
    ,name as ad_name
    ,cast(account_id as {{ dbt.type_bigint() }}) as account_id
    ,cast(adset_id as {{ dbt.type_bigint() }}) as adset_id
    ,cast(campaign_id as {{ dbt.type_bigint() }}) as campaign_id
    ,cast(jsonb_extract_path_text(creative, 'id') as {{ dbt.type_bigint() }}) as creative_id  -- WIP: json extract function should be compatible with BigQuery and Snowflake
    ,case when id is null and updated_time is null 
      then row_number() over (partition by _dbt_source_relation order by _dbt_source_relation)
    else row_number() over (partition by _dbt_source_relation, id order by updated_time desc) end = 1 as is_most_recent_record
  from unionned
)

select * from final
