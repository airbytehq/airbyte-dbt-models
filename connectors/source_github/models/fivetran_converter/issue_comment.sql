select
    cast(c.id as {{ dbt.type_string() }}) as id,
    cast(i.id as {{ dbt.type_string() }}) issue_id,
    {{ fivetran_utils.json_extract('c."user"', 'id') }} as user_id,
    c.created_at
from {{ source('source_github', 'comments') }} c
left join {{ source('source_github', 'issues') }} i on c.issue_url = i.url