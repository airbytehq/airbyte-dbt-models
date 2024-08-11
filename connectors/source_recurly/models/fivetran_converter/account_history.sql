{% if target.type == "snowflake" %}

    WITH tmp AS (
        SELECT
            t.id AS user_id,
            t.external_id AS external_id,
            t._fivetran_synced AS _fivetran_synced,
            cast(t.last_login_at as {{ dbt.type_timestamp() }}) AS last_login_at,
            cast(t.created_at as {{ dbt.type_timestamp() }}) AS created_at,
            cast(t.updated_at as {{ dbt.type_timestamp() }}) AS updated_at,
            t.email AS email,
            t.name AS name,
            t.organization_id AS organization_id,
            t.phone AS phone,
            {% if var('internal_user_criteria', false) -%}
                CASE 
                    WHEN t.role IN ('admin', 'agent') THEN t.role
                    WHEN {{ var('internal_user_criteria', false) }} THEN 'agent'
                ELSE t.role END AS role,
            {% else -%}
            t.role AS role,
            {% endif -%}
            t.ticket_restriction AS ticket_restriction,
            t.time_zone AS time_zone,
            t.locale AS locale,
            t.active AS is_active,
            t.suspended AS is_suspended
        FROM
            {{ source('source_recurly', 'accounts') }} t
    )
    SELECT * FROM tmp
    WHERE user_id IS NOT NULL

{% elif target.type == "bigquery" %}

    WITH tmp AS (
        SELECT
            t.id AS user_id,
            t.external_id AS external_id,
            t._fivetran_synced AS _fivetran_synced,
            cast(t.last_login_at as {{ dbt.type_timestamp() }}) AS last_login_at,
            cast(t.created_at as {{ dbt.type_timestamp() }}) AS created_at,
            cast(t.updated_at as {{ dbt.type_timestamp() }}) AS updated_at,
            t.email AS email,
            t.name AS name,
            t.organization_id AS organization_id,
            t.phone AS phone,
            {% if var('internal_user_criteria', false) -%}
                CASE 
                    WHEN t.role IN ('admin', 'agent') THEN t.role
                    WHEN {{ var('internal_user_criteria', false) }} THEN 'agent'
                ELSE t.role END AS role,
            {% else -%}
            t.role AS role,
            {% endif -%}
            t.ticket_restriction AS ticket_restriction,
            t.time_zone AS time_zone,
            t.locale AS locale,
            t.active AS is_active,
            t.suspended AS is_suspended
        FROM
            {{ source('source_recurly', 'accounts') }} t
    )
    SELECT * FROM tmp
    WHERE user_id IS NOT NULL

{% elif target.type == "postgres" %}

    WITH tmp AS (
        SELECT
            t.id AS user_id,
            t.external_id AS external_id,
            t._fivetran_synced AS _fivetran_synced,
            cast(t.last_login_at as {{ dbt.type_timestamp() }}) AS last_login_at,
            cast(t.created_at as {{ dbt.type_timestamp() }}) AS created_at,
            cast(t.updated_at as {{ dbt.type_timestamp() }}) AS updated_at,
            t.email AS email,
            t.name AS name,
            t.organization_id AS organization_id,
            t.phone AS phone,
            {% if var('internal_user_criteria', false) -%}
                CASE 
                    WHEN t.role IN ('admin', 'agent') THEN t.role
                    WHEN {{ var('internal_user_criteria', false) }} THEN 'agent'
                ELSE t.role END AS role,
            {% else -%}
            t.role AS role,
            {% endif -%}
            t.ticket_restriction AS ticket_restriction,
            t.time_zone AS time_zone,
            t.locale AS locale,
            t.active AS is_active,
            t.suspended AS is_suspended
        FROM
            {{ source('source_recurly', 'accounts') }} t
    )
    SELECT * FROM tmp
    WHERE user_id IS NOT NULL 

{% endif %}
