with base as ( select * from {{ source('source_facebook_marketing', 'ad_sets') }} )

,unionned as (
  select 
    {{ dbt.cast('null', api.Column.translate_type('string')) }} as _dbt_source_relation
    ,*
  from base
)

,final as (
  select
    _dbt_source_relation as source_relation
    ,updated_time as updated_at
    ,{{ dbt.cast("id", api.Column.translate_type("bigint")) }} as ad_set_id
    ,name as ad_set_name
    ,{{ dbt.cast("account_id", api.Column.translate_type("bigint")) }} as account_id
    ,{{ dbt.cast("campaign_id", api.Column.translate_type("bigint")) }} as campaign_id
    ,start_time as start_at
    ,end_time as end_at
    ,bid_strategy
    ,daily_budget
    ,budget_remaining
    ,effective_status as status
    ,case when id is null and updated_time is null 
      then row_number() over (partition by _dbt_source_relation order by _dbt_source_relation)
    else row_number() over (partition by _dbt_source_relation, id order by updated_time desc) end = 1 as is_most_recent_record
  from unionned
)

select * from final
