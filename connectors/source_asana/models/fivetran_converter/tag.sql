WITH tmp AS (
    SELECT
        t.gid as id,
        t.name,
        cast(t._airbyte_extracted_at as {{ dbt.type_timestamp() }}) as created_at --TODO: add created_at on source-asana
    FROM
        {{ source('source_asana', 'tags') }} t
)
SELECT * FROM tmp