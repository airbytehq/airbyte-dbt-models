select
    cast(id as {{ dbt.type_string() }}) as id,
    private,
    full_name
from {{ source('source_github', 'repositories') }} as r