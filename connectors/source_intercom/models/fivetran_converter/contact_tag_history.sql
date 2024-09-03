with contact_tag_array as (
  select
    id as contact_id,
    to_timestamp(updated_at) as contact_updated_at,
    cast(tags ->> 'data' as jsonb) as tag_array
  from {{source('source_intercom', 'contacts')}} c
)

select
  c.contact_id,
  c.contact_updated_at,
  f.value ->> 'id' as tag_id
from contact_tag_array c
join lateral jsonb_array_elements(c.tag_array) as f(value) on true
