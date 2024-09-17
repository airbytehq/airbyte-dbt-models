
SELECT
    cast(r.id as {{ dbt.type_string() }}) as id,
    cast(pr.id as {{ dbt.type_string() }}) as pull_request_id,
    r.submitted_at,
    r.state,
    {{ fivetran_utils.json_extract('r."user"', 'id') }} as user_id
FROM {{ source('source_github', 'reviews') }} as r
left join {{ source('source_github', 'pull_requests') }} as pr on r.pull_request_url = pr.url

