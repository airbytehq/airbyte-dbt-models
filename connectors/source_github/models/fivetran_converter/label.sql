select
    cast(id as {{ dbt.type_string() }}) as id,
    color,
    description,
    "default" as is_default,
    name,
    url
from {{ source('source_github', 'issue_labels') }}