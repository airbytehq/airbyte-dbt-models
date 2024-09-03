with base as (
    SELECT
        id,
        read,
        state,
        (sla_applied->>'sla_name') as sla_name,
        (sla_applied->>'sla_status') as sla_status,
        {{ fivetran_utils.json_extract('assignee', 'id') }} as assignee_id,
        {{ fivetran_utils.json_extract('assignee', 'type') }} as assignee_type,
        cast({{ fivetran_utils.json_extract('conversation_rating', 'rating') }} as {{ dbt.type_int() }}) as conversation_rating_value,
        {{ fivetran_utils.json_extract('conversation_rating', 'remark') }} as conversation_rating_remark,
        {{ fivetran_utils.json_extract('conversation_rating', 'created_at') }} as conversation_rating_created,
        {{ fivetran_utils.json_extract('first_contact_reply', 'type') }} as first_contact_reply_type,
        {{ fivetran_utils.json_extract('first_contact_reply', 'created_at') }} as first_contact_reply_created,
        (source->'author'->>'id') as source_author_id,
        (source->'author'->>'type') as source_author_type,
        (source->>'delivered_as') as source_delivered_as,
        (source->>'type') as source_type,
        (source->>'subject') as source_subject,
        to_timestamp(waiting_since) as waiting_since,
        to_timestamp(snoozed_until) as snoozed_until,
        to_timestamp(updated_at) as updated_at,
        to_timestamp(created_at) as created_at
    FROM
    {{source('source_intercom', 'conversations')}}
)
select
    *,
    to_timestamp(cast(conversation_rating_created as int)) as conversation_rating_created_at,
    to_timestamp(cast(first_contact_reply_created as int)) as first_contact_reply_created_at
from base as b