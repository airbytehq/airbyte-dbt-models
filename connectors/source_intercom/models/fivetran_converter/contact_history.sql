{% if target.type == "snowflake" %}

with base as (
    SELECT
        id as contact_id,
        owner_id as admin_id,
        {{ dbt.date_trunc('second', 'created_at'::timestamp) }} as created_at,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at,
        {{ dbt.date_trunc('second', 'signed_up_at'::timestamp) }} as signed_up_at,
        name as contact_name,
        role as contact_role,
        email as contact_email,
        {{ dbt.date_trunc('second', 'last_replied_at'::timestamp) }} as last_replied_at,
        {{ dbt.date_trunc('second', 'last_email_clicked_at'::timestamp) }} as last_email_clicked_at,
        {{ dbt.date_trunc('second', 'last_email_opened_at'::timestamp) }} as last_email_opened_at,
        {{ dbt.date_trunc('second', 'last_contacted_at'::timestamp) }} as last_contacted_at,
        unsubscribed_from_emails as is_unsubscribed_from_emails
    FROM
    {{source('source_intercom', 'contacts')}}
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id as contact_id,
        owner_id as admin_id,
        {{ dbt.date_trunc('second', 'created_at'::timestamp) }} as created_at,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at,
        {{ dbt.date_trunc('second', 'signed_up_at'::timestamp) }} as signed_up_at,
        name as contact_name,
        role as contact_role,
        email as contact_email,
        {{ dbt.date_trunc('second', 'last_replied_at'::timestamp) }} as last_replied_at,
        {{ dbt.date_trunc('second', 'last_email_clicked_at'::timestamp) }} as last_email_clicked_at,
        {{ dbt.date_trunc('second', 'last_email_opened_at'::timestamp) }} as last_email_opened_at,
        {{ dbt.date_trunc('second', 'last_contacted_at'::timestamp) }} as last_contacted_at,
        unsubscribed_from_emails as is_unsubscribed_from_emails
    FROM
    {{source('source_intercom', 'contacts')}}
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as contact_id,
        owner_id as admin_id,
        to_timestamp(created_at) as created_at,
        to_timestamp(updated_at) as updated_at,
        to_timestamp(signed_up_at) as signed_up_at,
        name as contact_name,
        role as contact_role,
        email as contact_email,
        to_timestamp(last_replied_at) as last_replied_at,
        to_timestamp(last_email_clicked_at) as last_email_clicked_at,
        to_timestamp(last_email_opened_at) as last_email_opened_at,
        to_timestamp(last_contacted_at) as last_contacted_at,
        unsubscribed_from_emails as is_unsubscribed_from_emails
    from {{source('source_intercom', 'contacts')}}
)
select * from base

{% endif %}
