with contact_company_array as (
  select
    id as contact_id,
    to_timestamp(updated_at) as contact_updated_at,
    cast(companies ->> 'data' as jsonb) as companies
  from {{source('source_intercom', 'contacts')}} c
)

select
  cca.contact_id,
  cca.contact_updated_at,
  f.value ->> 'id' as company_id
from contact_company_array cca
join lateral jsonb_array_elements(cca.companies) as f(value) on true
