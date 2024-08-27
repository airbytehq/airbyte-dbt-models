{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            segment_id,
            id AS member_id,
            list_id
        FROM
            {{ source('source_mailchimp', 'segment_members') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            segment_id,
            id AS member_id,
            list_id
        FROM
            {{ source('source_mailchimp', 'segment_members') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            segment_id,
            id AS member_id,
            list_id
        FROM
            {{ source('source_mailchimp', 'segment_members') }}
    )

    SELECT * FROM TMP

{% endif %}
