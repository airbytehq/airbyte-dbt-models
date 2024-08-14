{% set sources_dict = var('airbyte')['facebook_ads']['sources']['campaigns'] %}
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
    ,created_time as created_at
    ,cast(account_id as {{ dbt.type_bigint() }}) as account_id
    ,cast(id as {{ dbt.type_bigint() }}) as campaign_id
    ,name as campaign_name
    ,start_time as start_at
    ,stop_time as end_at
    ,status
    ,daily_budget
    ,lifetime_budget
    ,budget_remaining
    ,case when id is null and updated_time is null 
      then row_number() over (partition by _dbt_source_relation order by _dbt_source_relation)
    else row_number() over (partition by _dbt_source_relation, id order by updated_time desc) end = 1 as is_most_recent_record
  from unionned
)

select * from final
