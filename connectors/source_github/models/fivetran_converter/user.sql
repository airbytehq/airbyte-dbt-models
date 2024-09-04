select
    id,
    login,
    login as name,
    organization as company
from {{ source('source_github', 'users') }} as u