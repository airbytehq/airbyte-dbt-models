
{% if target.type == "postgres" %}

    WITH EventTypeCTE AS (
        SELECT
            id AS event_type_id,
            "value"
        FROM
            {{ source('source_amplitude', 'events_list') }}
    ),

    Events AS (
        SELECT
            _insert_id,
            "_schema" AS "schema",
            adid AS ad_id,
            amplitude_id,
            app,
            app AS project_name,
            city,
            client_event_time,
            client_upload_time,
            country,
            "data",
            device_brand,
            device_carrier,
            device_family,
            device_id,
            device_manufacturer,
            device_model,
            device_type,
            dma,
            event_id AS id,
            event_properties,
            event_time,
            event_type,
            group_properties,
            groups AS group_types,
            idfa,
            ip_address,
            is_attribution_event,
            "language",
            library,
            location_lat,
            location_lng,
            os_name,
            os_version,
            paying,
            platform,
            processed_time,
            region,
            server_received_time,
            server_upload_time,
            session_id,
            start_version,
            user_creation_time,
            user_id,
            user_properties,
            uuid,
            version_name
        FROM
            {{ source('source_amplitude', 'events') }}
    ),

    TMP AS (
        SELECT
            Events.*,
            EventTypeCTE.event_type_id
        FROM
            Events
        LEFT OUTER JOIN
            EventTypeCTE
        ON
            Events.event_type = EventTypeCTE.value
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH EventTypeCTE AS (
        SELECT
            id AS event_type_id,
            `value`
        FROM
            {{ source('source_amplitude', 'events_list') }}
    ),

    Events AS (
        SELECT
            _insert_id,
            _schema AS `schema`,
            adid AS ad_id,
            amplitude_id,
            app,
            app AS project_name,
            city,
            client_event_time,
            client_upload_time,
            country,
            `data`,
            device_brand,
            device_carrier,
            device_family,
            device_id,
            device_manufacturer,
            device_model,
            device_type,
            dma,
            event_id AS id,
            event_properties,
            event_time,
            event_type,
            group_properties,
            `groups` AS group_types,
            idfa,
            ip_address,
            is_attribution_event,
            `language`,
            library,
            location_lat,
            location_lng,
            os_name,
            os_version,
            paying,
            platform,
            processed_time,
            region,
            server_received_time,
            server_upload_time,
            session_id,
            start_version,
            user_creation_time,
            user_id,
            user_properties,
            uuid,
            version_name
        FROM
            {{ source('source_amplitude', 'events') }}
    ),

    TMP AS (
        SELECT
            Events.*,
            EventTypeCTE.event_type_id
        FROM
            Events
        LEFT OUTER JOIN
            EventTypeCTE
        ON
            Events.event_type = EventTypeCTE.value
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH EventTypeCTE AS (
        SELECT
            id AS event_type_id,
            "VALUE"
        FROM
            {{ source('source_amplitude', 'events_list') }}
    ),

    Events AS (
        SELECT
            "$INSERT_ID" as "INSERT_ID",
            "$SCHEMA" AS "SCHEMA",
            adid AS ad_id,
            amplitude_id,
            app,
            app AS project_name,
            city,
            client_event_time,
            client_upload_time,
            country,
            "DATA",
            device_brand,
            device_carrier,
            device_family,
            device_id,
            device_manufacturer,
            device_model,
            device_type,
            dma,
            event_id AS id,
            event_properties,
            event_time,
            event_type,
            group_properties,
            groups AS group_types,
            idfa,
            ip_address,
            is_attribution_event,
            "LANGUAGE",
            library,
            location_lat,
            location_lng,
            os_name,
            os_version,
            paying,
            platform,
            processed_time,
            region,
            server_received_time,
            server_upload_time,
            session_id,
            start_version,
            user_creation_time,
            user_id,
            user_properties,
            uuid,
            version_name
        FROM
            {{ source('source_amplitude', 'events') }}
    ),

    TMP AS (
        SELECT
            Events.*,
            EventTypeCTE.event_type_id
        FROM
            Events
        LEFT OUTER JOIN
            EventTypeCTE
        ON
            Events.event_type = EventTypeCTE.value
    )

    SELECT * FROM TMP
{%endif%}
