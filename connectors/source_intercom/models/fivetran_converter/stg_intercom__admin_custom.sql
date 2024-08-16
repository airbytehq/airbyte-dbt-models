{% if target.type == "snowflake" %}

    with tmp as (
        select
            id as admin_id,
            name,
            job_title
        from
            {{ source('source_intercom', 'admins') }}
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            id as admin_id,
            name,
            job_title
        from
            {{ source('source_intercom', 'admins') }}
    )
    select * from tmp

{% elif target.type == "postgres" %}

    with tmp as (
        select
            id as admin_id,
            name,
            job_title
        from
            {{ source('source_intercom', 'admins') }}
    )
    select * from tmp

{% endif %}
