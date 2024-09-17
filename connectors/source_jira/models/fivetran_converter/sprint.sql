
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            id,
            boardId AS board_id,
            completeDate AS complete_date,
            endDate AS end_date,
            name,
            startDate AS start_date
        FROM
            {{ source('source_jira', 'sprints') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            id,
            boardId AS board_id,
            completeDate AS complete_date,
            endDate AS end_date,
            name,
            startDate AS start_date
        FROM
            {{ source('source_jira', 'sprints') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            id,
            boardId AS board_id,
            completeDate AS complete_date,
            endDate AS end_date,
            name,
            startDate AS start_date
        FROM
            {{ source('source_jira', 'sprints') }}
    )

    SELECT * FROM TMP

{%endif%}
