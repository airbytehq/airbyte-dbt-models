select
    id,
    private,
    full_name
from {{ source('source_github', 'repositories') }} as r