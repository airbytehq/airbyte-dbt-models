with base as ( select * from {{ source('source_facebook_marketing', 'ad_creatives') }} )

,unionned as (
  select 
    {{ dbt.cast('null', api.Column.translate_type('string')) }} as source_relation
    ,*
  from base
)

,final as (
  select
    source_relation
    ,_airbyte_raw_id as _fivetran_id
    ,_airbyte_extracted_at as _fivetran_synced
    ,{{ dbt.cast("id", api.Column.translate_type("bigint")) }} as creative_id
    ,{{ dbt.cast("account_id", api.Column.translate_type("bigint")) }} as account_id
    ,name as creative_name

    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'link') as page_link -- WIP: oddly enough, this field is not present in the source and seem to always match the object_story.link_data.link field

    ,jsonb_extract_path_text(object_story_spec, 'template_data', 'link') as template_page_link -- WIP: closest field in the API
    ,url_tags
    ,{{ fivetran_utils.json_extract('asset_feed_spec', 'link_urls') }} as asset_feed_spec_link_urls
    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'child_attachments') as object_story_link_data_child_attachments
    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'caption') as object_story_link_data_caption
    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'description') as object_story_link_data_description
    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'link') as object_story_link_data_link
    ,jsonb_extract_path_text(object_story_spec, 'link_data', 'message') as object_story_link_data_message

    -- WIP: closest fields in the API
    ,jsonb_extract_path_text(template_url_spec, 'ios', 'url') as template_app_link_spec_ios
    ,jsonb_extract_path_text(template_url_spec, 'ipad', 'url') as template_app_link_spec_ipad
    ,jsonb_extract_path_text(template_url_spec, 'android', 'url') as template_app_link_spec_android

    ,case when id is null and _airbyte_extracted_at is null 
      then row_number() over (partition by source_relation order by source_relation)
    else row_number() over (partition by source_relation, id order by _airbyte_extracted_at desc) end = 1 as is_most_recent_record
  from unionned
)

select * from final