{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            id AS person_id,
            attributes:location:address1::STRING AS address_1,
            attributes:location:address2::STRING AS address_2,
            attributes:location:city::STRING AS city,
            attributes:location:country::STRING AS country,
            attributes:location:zip::STRING AS zip,
            attributes:location:latitude::STRING AS latitude,
            attributes:location:longitude::STRING AS longitude,
            attributes:location:region::STRING AS region, -- state in USA
            attributes:location:timezone::STRING AS timezone,
            attributes:created::STRING AS created_at,
            attributes:email::STRING AS email,
            (attributes:first_name::STRING) || ' ' || (attributes:last_name::STRING) AS full_name,
            attributes:organization::STRING AS organization,
            attributes:phone_number::STRING AS phone_number,
            attributes:title::STRING AS title,
            attributes:updated::STRING AS updated_at,
            attributes:last_event_date::STRING AS last_event_date
        FROM
            {{ source('source_klaviyo', 'profiles') }}
    )
    SELECT * FROM tmp
    WHERE person_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            id AS person_id,
            JSON_EXTRACT_SCALAR(attributes, '$.location.address1') AS address_1,
            JSON_EXTRACT_SCALAR(attributes, '$.location.address2') AS address_2,
            JSON_EXTRACT_SCALAR(attributes, '$.location.city') AS city,
            JSON_EXTRACT_SCALAR(attributes, '$.location.country') AS country,
            JSON_EXTRACT_SCALAR(attributes, '$.location.zip') AS zip,
            JSON_EXTRACT_SCALAR(attributes, '$.location.latitude') AS latitude,
            JSON_EXTRACT_SCALAR(attributes, '$.location.longitude') AS longitude,
            JSON_EXTRACT_SCALAR(attributes, '$.location.region') AS region, -- state in USA
            JSON_EXTRACT_SCALAR(attributes, '$.location.timezone') AS timezone,
            JSON_EXTRACT_SCALAR(attributes, '$.created') AS created_at,
            JSON_EXTRACT_SCALAR(attributes, '$.email') AS email,
            CONCAT(
                JSON_EXTRACT_SCALAR(attributes, '$.first_name'),
                ' ',
                JSON_EXTRACT_SCALAR(attributes, '$.last_name')
            ) AS full_name,
            JSON_EXTRACT_SCALAR(attributes, '$.organization') AS organization,
            JSON_EXTRACT_SCALAR(attributes, '$.phone_number') AS phone_number,
            JSON_EXTRACT_SCALAR(attributes, '$.title') AS title,
            JSON_EXTRACT_SCALAR(attributes, '$.updated') AS updated_at,
            JSON_EXTRACT_SCALAR(attributes, '$.last_event_date') AS last_event_date
        FROM
            {{ source('source_klaviyo', 'profiles') }}
    )
    SELECT * FROM tmp
    WHERE PERSON_ID IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            id AS person_id,
            attributes->'location'->>'address1' AS address_1,
            attributes->'location'->>'address2' AS address_2,
            attributes->'location'->>'city' AS city,
            attributes->'location'->>'country' AS country,
            attributes->'location'->>'zip' AS zip,
            attributes->'location'->>'latitude' AS latitude,
            attributes->'location'->>'longitude' AS longitude,
            attributes->'location'->>'region' AS region, -- state in USA
            attributes->'location'->>'timezone' AS timezone,
            attributes->>'created' AS created_at,
            attributes->>'email' AS email,
            (attributes->>'first_name') || ' ' || (attributes->>'last_name') AS full_name,
            attributes->>'organization' AS organization,
            attributes->>'phone_number' AS phone_number,
            attributes->>'title' AS title,
            attributes->>'updated' AS updated_at,
            attributes->>'last_event_date' AS last_event_date
        FROM
            {{ source('source_klaviyo', 'profiles') }}
    )
    SELECT * FROM tmp
    WHERE person_id IS NOT NULL

{% endif %}
