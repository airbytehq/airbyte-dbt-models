{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            -- Direct mappings
            id AS campaign_id,
            recipients ->> 'email_id' AS member_id,
            recipients ->> 'list_id' AS list_id,
            send_time AS activity_timestamp,
            variate_settings ->> 'combination_id' AS combination_id,

            -- Columns not present in Airbyte, setting them as NULL
            NULL AS action_type,
            NULL AS ip_address,
            NULL AS url,
            NULL AS bounce_type

        FROM
            {{ source('source_mailchimp', 'campaigns') }}
    ),

    -- Generating activity_id and email_id
    FINAL AS (
        SELECT
            *,
            {{ dbt_utils.generate_surrogate_key(['action_type', 'campaign_id', 'member_id', 'activity_timestamp']) }} AS activity_id,
            {{ dbt_utils.generate_surrogate_key(['campaign_id','member_id']) }} AS email_id
        FROM
            TMP
    )

    SELECT * FROM FINAL

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            id AS campaign_id,
            recipients.email_id AS member_id,
            recipients.list_id AS list_id,
            send_time AS activity_timestamp,
            variate_settings.combination_id AS combination_id,

            NULL AS action_type,
            NULL AS ip_address,
            NULL AS url,
            NULL AS bounce_type

        FROM
            {{ source('source_mailchimp', 'campaigns') }}
    ),

    FINAL AS (
        SELECT
            *,
            {{ dbt_utils.generate_surrogate_key(['action_type', 'campaign_id', 'member_id', 'activity_timestamp']) }} AS activity_id,
            {{ dbt_utils.generate_surrogate_key(['campaign_id','member_id']) }} AS email_id
        FROM
            TMP
    )

    SELECT * FROM FINAL

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            id AS campaign_id,
            recipients:email_id::string AS member_id,
            recipients:list_id::string AS list_id,
            send_time::timestamp AS activity_timestamp,
            variate_settings:combination_id::string AS combination_id,

            NULL AS action_type,
            NULL AS ip_address,
            NULL AS url,
            NULL AS bounce_type

        FROM
            {{ source('source_mailchimp', 'campaigns') }}
    ),

    FINAL AS (
        SELECT
            *,
            {{ dbt_utils.generate_surrogate_key(['action_type', 'campaign_id', 'member_id', 'activity_timestamp']) }} AS activity_id,
            {{ dbt_utils.generate_surrogate_key(['campaign_id','member_id']) }} AS email_id
        FROM
            TMP
    )

    SELECT * FROM FINAL

{% endif %}
