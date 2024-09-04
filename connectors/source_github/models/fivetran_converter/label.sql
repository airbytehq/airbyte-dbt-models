select
    id,
    color,
    description,
    "default" as is_default,
    name,
    url
from {{ source('source_github', 'issue_labels') }}