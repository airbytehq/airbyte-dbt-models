{% if target.type == "snowflake" %}

    SELECT
        type AS campaign_type,
        attributes:created_at::STRING AS created,
        -- email_template_id is excluded from the SELECT
        CASE 
            WHEN attributes:included IS NOT NULL THEN attributes:included[0].attributes:content.reply_to_email::STRING 
            ELSE NULL 
        END AS from_email,
        CASE 
            WHEN attributes:included IS NOT NULL THEN attributes:included[0].attributes:label::STRING 
            ELSE NULL 
        END AS from_name,
        id,
        attributes:name::STRING AS name,
        attributes:send_time::STRING AS send_time,
        -- sent_at is excluded from the SELECT
        attributes:status::STRING AS status,
        attributes:status::STRING AS status_label,
        -- status_id is excluded from the SELECT
        CASE 
            WHEN attributes:included IS NOT NULL THEN attributes:included[0].attributes:content.subject::STRING 
            ELSE NULL 
        END AS subject,
        attributes:updated_at::STRING AS updated,
        attributes:archived::STRING AS archived,
        attributes:scheduled_at::STRING AS scheduled
    FROM
        {{ source('source_klaviyo', 'campaigns') }}

{% elif target.type == "bigquery" %}

    SELECT
        type AS campaign_type,
        JSON_EXTRACT_SCALAR(attributes, '$.created_at') AS created,
        -- email_template_id is excluded from the SELECT
        CASE 
            WHEN JSON_EXTRACT(attributes, '$.included') IS NOT NULL THEN JSON_EXTRACT_SCALAR(attributes, '$.included[0].attributes.content.reply_to_email') 
            ELSE NULL 
        END AS from_email,
        CASE 
            WHEN JSON_EXTRACT(attributes, '$.included') IS NOT NULL THEN JSON_EXTRACT_SCALAR(attributes, '$.included[0].attributes.label') 
            ELSE NULL 
        END AS from_name,
        id,
        JSON_EXTRACT_SCALAR(attributes, '$.name') AS name,
        JSON_EXTRACT_SCALAR(attributes, '$.send_time') AS send_time,
        -- sent_at is excluded from the SELECT
        JSON_EXTRACT_SCALAR(attributes, '$.status') AS status,
        JSON_EXTRACT_SCALAR(attributes, '$.status') AS status_label,
        -- status_id is excluded from the SELECT
        CASE 
            WHEN JSON_EXTRACT(attributes, '$.included') IS NOT NULL THEN JSON_EXTRACT_SCALAR(attributes, '$.included[0].attributes.content.subject') 
            ELSE NULL 
        END AS subject,
        JSON_EXTRACT_SCALAR(attributes, '$.updated_at') AS updated,
        JSON_EXTRACT_SCALAR(attributes, '$.archived') AS archived,
        JSON_EXTRACT_SCALAR(attributes, '$.scheduled_at') AS scheduled
    FROM
        {{ source('source_klaviyo', 'campaigns') }}

{% elif target.type == "postgres" %}

    SELECT
        type AS campaign_type,
        attributes->>'created_at' AS created,
        -- email_template_id is excluded from the SELECT
        CASE 
            WHEN attributes ? 'included' THEN attributes->'included'->0->'attributes'->'content'->>'reply_to_email' 
            ELSE NULL 
        END AS from_email,
        CASE 
            WHEN attributes ? 'included' THEN attributes->'included'->0->'attributes'->>'label' 
            ELSE NULL 
        END AS from_name,
        id,
        attributes->>'name' AS name,
        attributes->>'send_time' AS send_time,
        -- sent_at is excluded from the SELECT
        attributes->>'status' AS status,
        attributes->>'status' AS status_label,
        -- status_id is excluded from the SELECT
        CASE 
            WHEN attributes ? 'included' THEN 
            attributes->'included'->0->'attributes'->'content'->>'subject' 
            ELSE NULL 
        END AS subject,
        attributes->>'updated_at' AS updated,
        attributes->>'archived' AS archived,
        attributes->>'scheduled_at' AS scheduled
    FROM
        {{ source('source_klaviyo', 'campaigns') }}

{% endif %}
