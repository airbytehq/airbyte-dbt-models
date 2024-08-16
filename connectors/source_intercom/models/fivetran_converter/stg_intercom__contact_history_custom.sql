{% if target.type == "snowflake" %}

    with tmp as (
        select
            id as contact_id,
            owner_id as admin_id,
            timestamp_ntz(created_at) as created_at,
            timestamp_ntz(updated_at) as updated_at,
            timestamp_ntz(signed_up_at) as signed_up_at,
            name as contact_name,
            role as contact_role,
            email as contact_email,
            timestamp_ntz(last_replied_at) as last_replied_at,
            timestamp_ntz(last_email_clicked_at) as last_email_clicked_at,
            timestamp_ntz(last_email_opened_at) as last_email_opened_at,
            timestamp_ntz(last_contacted_at) as last_contacted_at,
            unsubscribed_from_emails as is_unsubscribed_from_emails
        from
            {{ source('source_intercom', 'contacts') }}
    )
    select * from tmp

{% elif target.type == "bigquery" %}

    with tmp as (
        select
            id as contact_id,
            owner_id as admin_id,
            timestamp_seconds(created_at) as created_at,
            timestamp_seconds(updated_at) as updated_at,
            timestamp_seconds(signed_up_at) as signed_up_at,
            name as contact_name,
            role as contact_role,
            email as contact_email,
            timestamp_seconds(last_replied_at) as last_replied_at,
            timestamp_seconds(last_email_clicked_at) as last_email_clicked_at,
            timestamp_seconds(last_email_opened_at) as last_email_opened_at,
            timestamp_seconds(last_contacted_at) as last_contacted_at,
            unsubscribed_from_emails as is_unsubscribed_from_emails
        from
            {{ source('source_intercom', 'contacts') }}
    )
    select * from tmp

{% elif target.type == "postgres" %}

    with tmp as (
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
        from
            {{ source('source_intercom', 'contacts') }}
    )
    select * from tmp

{% endif %}
