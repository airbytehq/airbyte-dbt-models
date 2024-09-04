select
    id as issue_id,
    f.value ->> 'id' as label_id
from {{ source('source_github', 'issues') }} as i
join lateral jsonb_array_elements(i.labels) as f(value) on true