{% if target.type == "snowflake" %}

with base as (
    SELECT
        id as conversation_id,
        {{ dbt.date_trunc('second', 'created_at'::timestamp) }} as created_at,
        assignee:id as assignee_id,
        assignee:type as assignee_type,
        conversation_rating:rating as conversation_rating_value,
        conversation_rating:remark as conversation_rating_remark,
        {{ dbt.date_trunc('second', 'first_contact_reply:created_at'::timestamp) }} as first_contact_reply_created_at,
        first_contact_reply:type as first_contact_reply_type,
        read as is_read,
        source:author:id as source_author_id,
        source:author:type as source_author_type,
        source:delivered_as as source_delivered_as,
        source:type as source_type,
        source:subject as source_subject,
        state,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at,
        {{ dbt.date_trunc('second', 'waiting_since'::timestamp) }} as waiting_since,
        {{ dbt.date_trunc('second', 'snoozed_until'::timestamp) }} as snoozed_until,
        sla_applied:sla_name as sla_name,
        sla_applied:sla_status as sla_status
    FROM
        {{source('source_intercom', 'conversations')}},
        LATERAL FLATTEN(input => contacts)
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id as conversation_id,
        {{ dbt.date_trunc('second', 'created_at'::timestamp) }} as created_at,
        assignee:id as assignee_id,
        assignee:type as assignee_type,
        conversation_rating:rating as conversation_rating_value,
        conversation_rating:remark as conversation_rating_remark,
        {{ dbt.date_trunc('second', 'first_contact_reply:created_at'::timestamp) }} as first_contact_reply_created_at,
        first_contact_reply:type as first_contact_reply_type,
        read as is_read,
        source:author:id as source_author_id,
        source:author:type as source_author_type,
        source:delivered_as as source_delivered_as,
        source:type as source_type,
        source:subject as source_subject,
        state,
        {{ dbt.date_trunc('second', 'updated_at'::timestamp) }} as updated_at,
        {{ dbt.date_trunc('second', 'waiting_since'::timestamp) }} as waiting_since,
        {{ dbt.date_trunc('second', 'snoozed_until'::timestamp) }} as snoozed_until,
        sla_applied:sla_name as sla_name,
        sla_applied:sla_status as sla_status
    FROM
        {{source('source_intercom', 'conversations')}},
        UNNEST(contacts) as contact
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    select
        id as conversation_id,
        to_timestamp(created_at) as created_at,
        assignee->>'id' as assignee_id,
        assignee->>'type' as assignee_type,
        (conversation_rating->>'rating')::integer as conversation_rating_value,
        conversation_rating->>'remark' as conversation_rating_remark,
        to_timestamp(first_contact_reply->>'created_at') as first_contact_reply_created_at,
        first_contact_reply->>'type' as first_contact_reply_type,
        read as is_read,
        source->'author'->>'id' as source_author_id,
        source->'author'->>'type' as source_author_type,
        source->>'delivered_as' as source_delivered_as,
        source->>'type' as source_type,
        source->>'subject' as source_subject,
        state,
        to_timestamp(updated_at) as updated_at,
        to_timestamp(waiting_since) as waiting_since,
        to_timestamp(snoozed_until) as snoozed_until,
        sla_applied->>'sla_name' as sla_name,
        sla_applied->>'sla_status' as sla_status
    from {{source('source_intercom', 'conversations')}}
)
select * from base

{% endif %}
