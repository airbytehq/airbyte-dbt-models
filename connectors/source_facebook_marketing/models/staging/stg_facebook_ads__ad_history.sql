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
    ,{{ dbt.cast("id", api.Column.translate_type("bigint")) }} as ad_id
    ,name as ad_name
    ,{{ dbt.cast("account_id", api.Column.translate_type("bigint")) }} as account_id
    ,{{ dbt.cast("adset_id", api.Column.translate_type("bigint")) }} as adset_id
    ,{{ dbt.cast("campaign_id", api.Column.translate_type("bigint")) }} as campaign_id
    ,{{ dbt.cast(fivetran_utils.json_extract('creative', 'id'), api.Column.translate_type("bigint")) }} as creative_id
    ,case when id is null and updated_time is null 
      then row_number() over (partition by _dbt_source_relation order by _dbt_source_relation)
    else row_number() over (partition by _dbt_source_relation, id order by updated_time desc) end = 1 as is_most_recent_record
  from unionned
)

select * from final
