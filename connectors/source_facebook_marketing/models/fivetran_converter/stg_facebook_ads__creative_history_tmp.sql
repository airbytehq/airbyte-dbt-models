{{ config(enabled=var('ad_reporting__facebook_ads_enabled', True)) }}

with unionned as (
{{
  fivetran_utils.union_data(
    default_database=target.database,
    default_schema='source_facebook_marketing',
    table_identifier='ad_creatives', 
    database_variable='facebook_ads_database', 
    schema_variable='facebook_ads_schema', 
    union_schema_variable='facebook_ads_union_schemas',
    union_database_variable='facebook_ads_union_databases'
  )
}}
)

select 
  _airbyte_raw_id as _fivetran_id
  ,_airbyte_extracted_at as _fivetran_synced
  ,id
  ,account_id
  ,name
  ,jsonb_extract_path_text(object_story_spec, 'link_data', 'link') as page_link -- WIP: oddly enough, this field is not present in the source and seem to always match the object_story.link_data.link field
  ,jsonb_extract_path_text(object_story_spec, 'template_data', 'link') as template_page_link -- WIP: closest field in the API

  ,(
    select 
      json_agg(
        json_build_object(
          'key', split_part(param, '=', 1),
          'value', split_part(param, '=', 2)
        )
      )::text
    from unnest(string_to_array(url_tags, '&')) as param
  ) as url_tags

  ,{{ fivetran_utils.json_extract('asset_feed_spec', 'link_urls') }} as asset_feed_spec_link_urls
  ,jsonb_extract_path_text(object_story_spec, 'link_data', 'child_attachments') as object_story_link_data_child_attachments
  ,jsonb_extract_path_text(object_story_spec, 'link_data', 'caption') as object_story_link_data_caption
  ,jsonb_extract_path_text(object_story_spec, 'link_data', 'description') as object_story_link_data_description
  ,jsonb_extract_path_text(object_story_spec, 'link_data', 'link') as object_story_link_data_link
  ,jsonb_extract_path_text(object_story_spec, 'link_data', 'message') as object_story_link_data_message

  -- WIP: closest fields in the API
  ,jsonb_extract_path_text(template_url_spec, 'android', 'url') as template_app_link_spec_android
  ,jsonb_extract_path_text(template_url_spec, 'ios', 'url') as template_app_link_spec_ios
  ,jsonb_extract_path_text(template_url_spec, 'ipad', 'url') as template_app_link_spec_ipad
  ,jsonb_extract_path_text(template_url_spec, 'iphone', 'url') as template_app_link_spec_iphone

from unionned
