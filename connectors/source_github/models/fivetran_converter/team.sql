select
    id,
    description,
    name,
    {{ fivetran_utils.json_extract('parent', 'id')}} as parent_id,
    privacy,
    slug
from {{ source('source_github', 'teams') }} as t