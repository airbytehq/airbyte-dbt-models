{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            p.id AS person_id,
            p.attributes:location:address1::STRING AS address_1,
            p.attributes:location:address2::STRING AS address_2,
            p.attributes:location:city::STRING AS city,
            p.attributes:location:country::STRING AS country,
            p.attributes:location:zip::STRING AS zip,
            p.attributes:location:latitude::STRING AS latitude,
            p.attributes:location:longitude::STRING AS longitude,
            p.attributes:location:region::STRING AS region, -- state in USA
            p.attributes:location:timezone::STRING AS timezone,
            p.attributes:created::STRING AS created_at,
            p.attributes:email::STRING AS email,
            (p.attributes:first_name::STRING) || ' ' || (p.attributes:last_name::STRING) AS full_name,
            p.attributes:organization::STRING AS organization,
            p.attributes:phone_number::STRING AS phone_number,
            p.attributes:title::STRING AS title,
            p.attributes:updated::STRING AS updated_at,
            p.attributes:last_event_date::STRING AS last_event_date
        FROM
            {{ source('source_klaviyo', 'profiles') }} p
    )
    SELECT * FROM tmp
    WHERE person_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            p.id AS person_id,
            JSON_EXTRACT_SCALAR(p.attributes, '$.location.address1') AS address_1,
            JSON_EXTRACT_SCALAR(p.attributes, '$.location.address2') AS address_2,
            JSON_EXTRACT_SCALAR(p.attributes, '$.location.city') AS city,
            JSON_EXTRACT_SCALAR(p.attributes, '$.location.country') AS country,
            JSON_EXTRACT_SCALAR(p.attributes, '$.location.zip') AS zip,
            JSON_EXTRACT_SCALAR(p.attributes, '$.location.latitude') AS latitude,
            JSON_EXTRACT_SCALAR(p.attributes, '$.location.longitude') AS longitude,
            JSON_EXTRACT_SCALAR(p.attributes, '$.location.region') AS region, -- state in USA
            JSON_EXTRACT_SCALAR(p.attributes, '$.location.timezone') AS timezone,
            JSON_EXTRACT_SCALAR(p.attributes, '$.created') AS created_at,
            JSON_EXTRACT_SCALAR(p.attributes, '$.email') AS email,
            CONCAT(
                JSON_EXTRACT_SCALAR(p.attributes, '$.first_name'),
                ' ',
                JSON_EXTRACT_SCALAR(p.attributes, '$.last_name')
            ) AS full_name,
            JSON_EXTRACT_SCALAR(p.attributes, '$.organization') AS organization,
            JSON_EXTRACT_SCALAR(p.attributes, '$.phone_number') AS phone_number,
            JSON_EXTRACT_SCALAR(p.attributes, '$.title') AS title,
            JSON_EXTRACT_SCALAR(p.attributes, '$.updated') AS updated_at,
            JSON_EXTRACT_SCALAR(p.attributes, '$.last_event_date') AS last_event_date
        FROM
            {{ source('source_klaviyo', 'profiles') }} p
    )
    SELECT * FROM tmp
    WHERE PERSON_ID IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            p.id AS person_id,
            p.attributes->'location'->>'address1' AS address_1,
            p.attributes->'location'->>'address2' AS address_2,
            p.attributes->'location'->>'city' AS city,
            p.attributes->'location'->>'country' AS country,
            p.attributes->'location'->>'zip' AS zip,
            p.attributes->'location'->>'latitude' AS latitude,
            p.attributes->'location'->>'longitude' AS longitude,
            p.attributes->'location'->>'region' AS region, -- state in USA
            p.attributes->'location'->>'timezone' AS timezone,
            p.attributes->>'created' AS created_at,
            p.attributes->>'email' AS email,
            (p.attributes->>'first_name') || ' ' || (p.attributes->>'last_name') AS full_name,
            p.attributes->>'organization' AS organization,
            p.attributes->>'phone_number' AS phone_number,
            p.attributes->>'title' AS title,
            p.attributes->>'updated' AS updated_at,
            p.attributes->>'last_event_date' AS last_event_date
        FROM
            {{ source('source_klaviyo', 'profiles') }} p
    )
    SELECT * FROM tmp
    WHERE person_id IS NOT NULL

{% endif %}
