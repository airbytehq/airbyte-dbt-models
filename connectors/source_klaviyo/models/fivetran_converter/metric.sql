{% if target.type == "snowflake" %}

    SELECT
        id AS metric_id,
        attributes:name::STRING AS metric_name,
        attributes:created::STRING AS created_at,
        updated::STRING AS updated_at,
        attributes:integration:id::STRING AS integration_id,
        attributes:integration:category::STRING AS integration_category,
        attributes:integration:name::STRING AS integration_name
    FROM
        {{ source('source_klaviyo', 'metrics') }}


{% elif target.type == "bigquery" %}

    SELECT
        id AS metric_id,
        JSON_EXTRACT_SCALAR(attributes, '$.name') AS metric_name,
        JSON_EXTRACT_SCALAR(attributes, '$.created') AS created_at,
        updated AS updated_at,
        JSON_EXTRACT_SCALAR(attributes, '$.integration.id') AS integration_id,
        JSON_EXTRACT_SCALAR(attributes, '$.integration.category') AS integration_category,
        JSON_EXTRACT_SCALAR(attributes, '$.integration.name') AS integration_name
    FROM
        {{ source('source_klaviyo', 'metrics') }}


{% elif target.type == "postgres" %}

    SELECT
        id AS metric_id,
        attributes->>'name' AS metric_name,
        attributes->>'created' AS created_at,
        updated AS updated_at,
        attributes->'integration'->>'id' AS integration_id,
        attributes->'integration'->>'category' AS integration_category,
        attributes->'integration'->>'name' AS integration_name
    FROM
        {{ source('source_klaviyo', 'metrics') }}


{% endif %}
