WITH TMP AS (
    SELECT
        cast(id as {{ dbt.type_string() }}) as id,
        name,
        type,
        updated_at,
        created_at,
        list_id,
        member_count
    FROM
        {{ source('source_mailchimp', 'segments') }}
)

SELECT * FROM TMP