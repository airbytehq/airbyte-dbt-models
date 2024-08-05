{% if target.type == "snowflake" %}

    with tmp as (
        SELECT
            t.id as TICKET_ID,
            f.value:field_name::STRING AS FIELD_NAME,
            f.value:value::STRING AS VALUE,
            t.author_id as AUTHOR_ID,
            t.created_at as UPDATED
        FROM
            {{ source('source_zendesk_support', 'ticket_audits') }} t,
            LATERAL FLATTEN(input => t.events) f
        )
    select * from tmp where field_name is not null

{% elif target.type == "bigquery" %}

        WITH tmp AS (
            SELECT
                t.id AS TICKET_ID,
                JSON_EXTRACT_SCALAR(f, '$.field_name') AS FIELD_NAME,
                JSON_EXTRACT_SCALAR(f, '$.value') AS VALUE,
                t.author_id AS AUTHOR_ID,
                t.created_at AS UPDATED
            FROM
            {{ source('source_zendesk_support', 'ticket_audits') }} t,
            UNNEST(JSON_EXTRACT_ARRAY(t.events)) AS f
        )
        SELECT * FROM tmp
        WHERE FIELD_NAME IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            t.id AS ticket_id,
            f.value->>'field_name' AS field_name,
            f.value->>'value' AS value,
            t.author_id AS author_id,
            t.created_at AS updated
        FROM
            {{ source('source_zendesk_support', 'ticket_audits') }} t,
            LATERAL jsonb_array_elements(t.events::jsonb) AS f(value)
    )
    SELECT * FROM tmp
    WHERE FIELD_NAME IS NOT NULL

{%endif%}