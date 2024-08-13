{% if target.type == "snowflake" %}

    SELECT
        id AS flow_id,
        attributes:created::STRING AS created_at,
        attributes:name::STRING AS flow_name,
        attributes:status::STRING AS status,
        attributes:updated::STRING AS updated_at,
        attributes:archived::STRING AS is_archived,
        attributes:trigger_type::STRING AS trigger_type
    FROM 
        {{ source('airbyte_dbt_source_klaviyo', 'flows') }}
    WHERE 
        flow_id IS NOT NULL;

{% elif target.type == "bigquery" %}

    SELECT
        id AS flow_id,
        JSON_EXTRACT_SCALAR(attributes, '$.created') AS created_at,
        JSON_EXTRACT_SCALAR(attributes, '$.name') AS flow_name,
        JSON_EXTRACT_SCALAR(attributes, '$.status') AS status,
        JSON_EXTRACT_SCALAR(attributes, '$.updated') AS updated_at,
        JSON_EXTRACT_SCALAR(attributes, '$.archived') AS is_archived,
        JSON_EXTRACT_SCALAR(attributes, '$.trigger_type') AS trigger_type
    FROM 
        {{ source('airbyte_dbt_source_klaviyo', 'flows') }}
    WHERE 
        flow_id IS NOT NULL;

{% elif target.type == "postgres" %}

    SELECT
        id AS flow_id,
        attributes->>'created' AS created_at,
        attributes->>'name' AS flow_name,
        attributes->>'status' AS status,
        attributes->>'updated' AS updated_at,
        attributes->>'archived' AS is_archived,
        attributes->>'trigger_type' AS trigger_type
    FROM 
        {{ source('airbyte_dbt_source_klaviyo', 'flows') }}
    WHERE 
        flow_id IS NOT NULL;

{% endif %}
