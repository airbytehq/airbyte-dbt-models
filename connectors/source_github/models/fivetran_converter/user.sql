select
    cast(id as {{ dbt.type_string() }}) as id,
    login,
    login as name,
    organization as company
from {{ source('source_github', 'users') }} as u