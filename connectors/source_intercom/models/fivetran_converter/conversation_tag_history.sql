with conversation_tag_array as (
  select
  id,
  to_timestamp(updated_at) as updated_at,
  cast(tags ->> 'tags' as jsonb) as tags_array
  from {{source('source_intercom', 'conversations')}} c
)

select
  cta.id as conversation_id,
  cta.updated_at as updated_at,
  f.value ->> 'id' as tag_id
from conversation_tag_array cta
join lateral jsonb_array_elements(cta.tags_array) as f(value) on true
