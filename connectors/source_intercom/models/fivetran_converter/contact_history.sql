with base as (
    select
        id,
        owner_id as admin_id,
        name,
        role,
        email,
        unsubscribed_from_emails,
        to_timestamp(created_at) as created_at,
        to_timestamp(updated_at) as updated_at,
        to_timestamp(signed_up_at) as signed_up_at,
        to_timestamp(last_replied_at) as last_replied_at,
        to_timestamp(last_email_clicked_at) as last_email_clicked_at,
        to_timestamp(last_email_opened_at) as last_email_opened_at,
        to_timestamp(last_contacted_at) as last_contacted_at
    from
    {{source('source_intercom', 'contacts')}}
)
select * from base