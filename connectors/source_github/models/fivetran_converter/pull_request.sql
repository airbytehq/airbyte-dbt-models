select
    pr.id,
    i.id as issue_id,
    {{ fivetran_utils.json_extract('head', 'repo_id')}} as head_repo_id,
    head -> 'user' ->> 'id' as head_user_id
from {{ source('source_github', 'pull_requests') }} as pr
left join {{ source('source_github', 'issues') }} as i on pr.issue_url = i.url