with base as ( select * from {{ source('source_facebook_marketing', 'campaigns') }} )

,unionned as (
  select 
    {{ dbt.cast('null', api.Column.translate_type('string')) }} as source_relation
    ,*
  from base
)

,final as (
  select
    coalesce(source_relation, '') as source_relation
    ,updated_time as updated_at
    ,created_time as created_at
    ,{{ dbt.cast("account_id", api.Column.translate_type("bigint")) }} as account_id
    ,{{ dbt.cast("id", api.Column.translate_type("bigint")) }} as campaign_id
    ,name as campaign_name
    ,start_time as start_at
    ,stop_time as end_at
    ,status
    ,daily_budget
    ,lifetime_budget
    ,budget_remaining
    ,case when id is null and updated_time is null 
      then row_number() over (partition by source_relation order by source_relation)
    else row_number() over (partition by source_relation, id order by updated_time desc) end = 1 as is_most_recent_record
  from unionned
)

select * from final
