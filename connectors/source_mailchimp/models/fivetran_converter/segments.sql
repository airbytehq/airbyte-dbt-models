{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            id AS segment_id,
            name AS segment_name,
            type AS segment_type,
            updated_at AS updated_timestamp,
            created_at AS created_timestamp,
            list_id,
            member_count
        FROM
            {{ source('source_mailchimp', 'segments') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            id AS segment_id,
            name AS segment_name,
            type AS segment_type,
            updated_at AS updated_timestamp,
            created_at AS created_timestamp,
            list_id,
            member_count
        FROM
            {{ source('source_mailchimp', 'segments') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            id AS segment_id,
            name AS segment_name,
            type AS segment_type,
            updated_at AS updated_timestamp,
            created_at AS created_timestamp,
            list_id,
            member_count
        FROM
            {{ source('source_mailchimp', 'segments') }}
    )

    SELECT * FROM TMP

{% endif %}
