with tags_array as (
  select
  id,
  to_timestamp(updated_at) as updated_at,
  cast(tags ->> 'tags' as jsonb) as tags_array
  from {{source('source_intercom', 'companies')}} c
)

select
  ta.id as contact_id,
  ta.updated_at as updated_at,
  f.value ->> 'id' as tag_id
from tags_array ta
join lateral jsonb_array_elements(ta.tags_array) as f(value) on true
