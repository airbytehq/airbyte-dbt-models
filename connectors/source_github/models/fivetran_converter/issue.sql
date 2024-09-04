select
      id as issue_id,
      body,
      closed_at,
      created_at,
      locked,
      {{ fivetran_utils.json_extract('milestone', 'id') }} as milestone_id,
      number,
      pull_request,
      repository as repository_id,
      state,
      title,
      updated_at,
      {{ fivetran_utils.json_extract('"user"', 'id') }} as user_id
from {{ source('source_github', 'issues') }}