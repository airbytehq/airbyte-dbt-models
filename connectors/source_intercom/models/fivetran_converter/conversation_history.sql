{% if target.type == "snowflake" %}

with base as (
    SELECT
        id as conversation_id,
        {{ dbt.date_trunc('second', created_at) }} as created_at,
        assignee:id as assignee_id,
        assignee:type as assignee_type,
        conversation_rating.rating as conversation_rating_value,
        conversation_rating.remark as conversation_rating_remark,
        first_contact_reply.created_at as first_contact_reply_created_at,
        first_contact_reply.type as first_contact_reply_type,
        read as is_read,
        source.author.id as source_author_id,
        source.author.type as source_author_type,
        source.delivered_as as source_delivered_as,
        source.type as source_type,
        source.subject as source_subject,
        state,
        {{ dbt.date_trunc('second', updated_at) }} as updated_at,
        {{ dbt.date_trunc('second', waiting_since) }} as waiting_since,
        {{ dbt.date_trunc('second', snoozed_until) }} as snoozed_until,
        sla_applied.sla_name as sla_name,
        sla_applied.sla_status as sla_status
    FROM
    {{source('source_intercom', 'conversations')}}
)
select * from base

{% elif target.type == "bigquery" %}

with base as (
    SELECT
        id as conversation_id,
        {{ dbt.date_trunc('second', created_at) }} as created_at,
        JSON_EXTRACT_SCALAR(assignee, '$.id') as assignee_id,
        JSON_EXTRACT_SCALAR(assignee, '$.type') as assignee_type,
        JSON_EXTRACT_SCALAR(conversation_rating, '$.rating') as conversation_rating_value,
        JSON_EXTRACT_SCALAR(conversation_rating, '$.remark') as conversation_rating_remark,
        JSON_EXTRACT_SCALAR(first_contact_reply, '$.created_at') as first_contact_reply_created_at,
        JSON_EXTRACT_SCALAR(first_contact_reply, '$.type') as first_contact_reply_type,
        read as is_read,
        JSON_EXTRACT_SCALAR(source, '$.author.id') as source_author_id,
        JSON_EXTRACT_SCALAR(source, '$.author.type') as source_author_type,
        JSON_EXTRACT_SCALAR(source, '$.delivered_as') as source_delivered_as,
        JSON_EXTRACT_SCALAR(source, '$.type') as source_type,
        JSON_EXTRACT_SCALAR(source, '$.subject') as source_subject,
        state,
        {{ dbt.date_trunc('second', updated_at) }} as updated_at,
        {{ dbt.date_trunc('second', waiting_since) }} as waiting_since,
        {{ dbt.date_trunc('second', snoozed_until) }} as snoozed_until,
        JSON_EXTRACT_SCALAR(sla_applied, '$.sla_name') as sla_name,
        JSON_EXTRACT_SCALAR(sla_applied, '$.sla_status') as sla_status
    FROM
    {{source('source_intercom', 'conversations')}}
)
select * from base

{% elif target.type == "postgres" %}

with base as (
    SELECT
        id as conversation_id,
        CAST(created_at AS timestamp) as created_at_ts,
        {{ dbt.date_trunc('second', 'created_at_ts') }} as created_at,
        (assignee->>'id') as assignee_id,
        (assignee->>'type') as assignee_type,
        (conversation_rating->>'rating') as conversation_rating_value,
        (conversation_rating->>'remark') as conversation_rating_remark,
        (first_contact_reply->>'created_at') as first_contact_reply_created_at,
        (first_contact_reply->>'type') as first_contact_reply_type,
        read as is_read,
        (source->'author'->>'id') as source_author_id,
        (source->'author'->>'type') as source_author_type,
        (source->>'delivered_as') as source_delivered_as,
        (source->>'type') as source_type,
        (source->>'subject') as source_subject,
        state,
        CAST(updated_at AS timestamp) as updated_at_ts,
        {{ dbt.date_trunc('second', 'updated_at_ts') }} as updated_at,
        CAST(waiting_since AS timestamp) as waiting_since_ts,
        {{ dbt.date_trunc('second', 'waiting_since_ts') }} as waiting_since,
        CAST(snoozed_until AS timestamp) as snoozed_until_ts,
        {{ dbt.date_trunc('second', 'snoozed_until_ts') }} as snoozed_until,
        (sla_applied->>'sla_name') as sla_name,
        (sla_applied->>'sla_status') as sla_status
    FROM
    {{source('source_intercom', 'conversations')}}
)
select * from base

{% endif %}
