    with tmp as (
        select
            cast(id as {{ dbt.type_string() }}) as account_id,
            name as account_name,
            currency as currency,
            version as version_tag,
            status,
            type,
            "lastModified" as last_modified_at,
            created as created_at,
            row_number() over (partition by id order by "lastModified" desc) = 1 as is_latest_version,
            null as source_relation
        from
            {{ source('source_linkedin_ads', 'accounts') }}
    )
    select * from tmp