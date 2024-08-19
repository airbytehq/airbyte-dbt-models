with base as ( select * from {{ source('source_facebook_marketing', 'ads') }} )

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
    ,{{ dbt.cast("id", api.Column.translate_type("bigint")) }} as ad_id
    ,name as ad_name
    ,{{ dbt.cast("account_id", api.Column.translate_type("bigint")) }} as account_id
    ,{{ dbt.cast("adset_id", api.Column.translate_type("bigint")) }} as ad_set_id
    ,{{ dbt.cast("campaign_id", api.Column.translate_type("bigint")) }} as campaign_id
    ,{{ dbt.cast(fivetran_utils.json_extract('creative', 'id'), api.Column.translate_type("bigint")) }} as creative_id
    ,case when id is null and updated_time is null 
      then row_number() over (partition by source_relation order by source_relation)
    else row_number() over (partition by source_relation, id order by updated_time desc) end = 1 as is_most_recent_record
  from unionned
)

select * from final
