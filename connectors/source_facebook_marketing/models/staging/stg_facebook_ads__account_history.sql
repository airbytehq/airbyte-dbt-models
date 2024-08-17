{% set sources_dict = var('airbyte')['facebook_ads']['sources']['ad_accounts'] %}
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
    ,{{ dbt.cast("account_id", api.Column.translate_type("bigint")) }} as account_id
    ,_airbyte_extracted_at as _fivetran_synced
    ,name as account_name
    ,account_status
    ,business_country_code
    ,created_time as created_at
    ,currency
    ,timezone_name
    ,case when account_id is null and _airbyte_extracted_at is null 
      then row_number() over (partition by _dbt_source_relation order by _dbt_source_relation)
    else row_number() over (partition by _dbt_source_relation, account_id order by _airbyte_extracted_at desc) end = 1 as is_most_recent_record
  from unionned
)

select * from final

