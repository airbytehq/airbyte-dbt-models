{% set sources_dict = var('airbyte')['facebook_ads']['sources']['ad_creatives'] %}
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
    {# ,_fivetran_id #}
    ,_airbyte_extracted_at as _fivetran_synced
    ,cast(id as {{ dbt.type_bigint() }}) as creative_id
    ,cast(account_id as {{ dbt.type_bigint() }}) as account_id
    ,name as creative_name
    {# ,page_link #}
    {# ,template_page_link #}
    ,url_tags
    ,jsonb_extract_path_text(asset_feed_spec, 'link_urls') as asset_feed_spec_link_urls
    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'child_attachments') as object_story_link_data_child_attachments
    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'caption') as object_story_link_data_caption
    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'description') as object_story_link_data_description
    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'link') as object_story_link_data_link
    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'message') as object_story_link_data_message

    {# ,template_app_link_spec_ios
    ,template_app_link_spec_ipad
    ,template_app_link_spec_android
    ,template_app_link_spec_iphone #}

    ,case when id is null and _airbyte_extracted_at is null 
      then row_number() over (partition by _dbt_source_relation order by _dbt_source_relation)
    else row_number() over (partition by _dbt_source_relation, id order by _airbyte_extracted_at desc) end = 1 as is_most_recent_record
  from unionned
)

select * from final
