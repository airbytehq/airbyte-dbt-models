with conversation_contact_array as (
  select
    id as conversation_id,
    to_timestamp(updated_at) as conversation_updated_at,
    cast(contacts ->> 'contacts' as jsonb) as contact_array
  from {{source('source_intercom', 'conversations')}} c
)

select
  c.conversation_id,
  c.conversation_updated_at,
  f.value ->> 'id' as contact_id
from conversation_contact_array c
join lateral jsonb_array_elements(c.contact_array) as f(value) on true
