with base as ( select * from {{ source('source_facebook_marketing', 'ads_insights') }} )

,unionned as (
  select 
    {{ dbt.cast('null', api.Column.translate_type('string')) }} as source_relation
    ,*
  from base
)

,final as (
  select
    coalesce(source_relation, '') as source_relation
    ,{{ dbt.cast("ad_id", api.Column.translate_type("bigint")) }} as ad_id
    ,ad_name
    ,adset_name as ad_set_name
    ,date_start as date_day -- WIP: check data type
    ,{{ dbt.cast("account_id", api.Column.translate_type("bigint")) }} as account_id
    ,impressions
    ,coalesce(inline_link_clicks,0) as clicks
    ,spend

    {# 
        Reach and Frequency are not included in downstream models by default, though they are included in the staging model.
        The below ensures that users can add Reach and Frequency to downstream models with the `basic_ad_passthrough_metrics` variable
        while avoiding duplicate column errors.
    #}
    {%- set check = [] %}
    {%- for field in var('facebook_ads__basic_ad_passthrough_metrics', []) -%}
      {%- set field_name = field.alias|default(field.name)|lower %}
      {% if field_name in ['reach', 'frequency'] %}
        {% do check.append(field_name) %}
      {% endif %}
    {%- endfor %}

    {%- for metric in ['reach', 'frequency'] -%}
      {% if metric not in check %}
        ,{{ metric }}
      {% endif %}
    {%- endfor %}

    {{ fill_pass_through_columns(var('facebook_ads__basic_ad_passthrough_metrics', [])) }}

    from unionned
)

select * from final
