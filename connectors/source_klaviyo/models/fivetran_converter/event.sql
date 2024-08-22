{% if target.type == "snowflake" %}

    SELECT
        -- included:0:relationships:flow-message-variation:data:id::STRING AS variation,
        -- included:0:relationships:flow:campaign:id::STRING AS campaign_id,

        attributes:event_properties:"$flow"::STRING AS flow_id,
        attributes:event_properties:"$message"::STRING AS flow_message_id,
        DATE_FROM_UNIXTIME(CAST(attributes:timestamp AS NUMBER)) AS timestamp,
        attributes:datetime::STRING AS datetime,
        id,
        relationships:metric:data:id::STRING AS metric_id,
        relationships:profile:data:id::STRING AS person_id,
        type,
        attributes:uuid::STRING AS uuid
    FROM
        {{ source('source_klaviyo', 'events') }}

{% elif target.type == "bigquery" %}

    SELECT
        -- JSON_EXTRACT_SCALAR(included, '$[0].relationships.flow-message-variation.data.id') AS variation,
        -- JSON_EXTRACT_SCALAR(included, '$[0].relationships.flow.campaign.id') AS campaign_id,

        JSON_EXTRACT_SCALAR(attributes, '$.event_properties.$flow') AS flow_id,
        JSON_EXTRACT_SCALAR(attributes, '$.event_properties.$message') AS flow_message_id,
        TIMESTAMP_SECONDS(CAST(JSON_EXTRACT_SCALAR(attributes, '$.timestamp') AS INT64)) AS timestamp,
        JSON_EXTRACT_SCALAR(attributes, '$.datetime') AS datetime,
        id,
        JSON_EXTRACT_SCALAR(relationships, '$.metric.data.id') AS metric_id,
        JSON_EXTRACT_SCALAR(relationships, '$.profile.data.id') AS person_id,
        type,
        JSON_EXTRACT_SCALAR(attributes, '$.uuid') AS uuid
    FROM
        {{ source('source_klaviyo', 'events') }}

{% elif target.type == "postgres" %}

    SELECT
        -- included->0->'relationships'->'flow-message-variation'->'data'->>'id' AS variation,
        -- included->0->'relationships'->'flow'->'campaign'->'id' AS campaign_id,
        to_timestamp((attributes->>'timestamp')::bigint) AS timestamp,
        attributes->'event_properties'->>'$flow' AS flow_id,
        attributes->'event_properties'->>'$message' AS flow_message_id,
        attributes->>'datetime' AS datetime,
        id,
        relationships->'metric'->'data'->>'id' AS metric_id,
        relationships->'profile'->'data'->>'id' AS person_id,
        type,
        attributes->>'uuid' AS uuid
    FROM
        {{ source('source_klaviyo', 'events') }}

{% endif %}
