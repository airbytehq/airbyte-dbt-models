{% if target.type == "snowflake" %}

    with tmp as (
        select
            accounts.id as account_id,
            accounts.name as account_name,
            accounts.currency as currency,
            accounts."version" as version_tag,
            accounts.status as status,
            accounts.type as type,
            {{ dbt.date_trunc('second', 'accounts."lastModified"') }} as last_modified_at,
            {{ dbt.date_trunc('second', 'accounts."created"') }} as created_at
        from
            {{ source('source_linkedin_ads', 'accounts') }} as accounts
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            accounts.id as account_id,
            accounts.name as account_name,
            accounts.currency as currency,
            accounts."version" as version_tag,
            accounts.status as status,
            accounts.type as type,
            {{ dbt.date_trunc('second', 'accounts."lastModified"') }} as last_modified_at,
            {{ dbt.date_trunc('second', 'accounts."created"') }} as created_at
        from
            {{ source('source_linkedin_ads', 'accounts') }} as accounts
    )
    select * from tmp

{% elif target.type == "postgres" %}

    with tmp as (
        select
            accounts.id as account_id,
            accounts.name as account_name,
            accounts.currency as currency,
            accounts."version" as version_tag,
            accounts.status as status,
            accounts.type as type,
            {{ dbt.date_trunc('second', 'accounts."lastModified"') }} as last_modified_at,
            {{ dbt.date_trunc('second', 'accounts."created"') }} as created_at
        from
            {{ source('source_linkedin_ads', 'accounts') }} as accounts
    )
    select * from tmp

{% endif %}
