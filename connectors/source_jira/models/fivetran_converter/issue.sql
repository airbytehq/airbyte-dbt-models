
{% if target.type == "postgres" %}

    WITH TMP AS (
        SELECT
            fields->'timetracking'->>'originalEstimateSeconds' AS _original_estimate,
            fields->'timetracking'->>'originalEstimateSeconds' AS original_estimate,
            fields->'timetracking'->>'remainingEstimateSeconds' AS _remaining_estimate,
            fields->'timetracking'->>'remainingEstimateSeconds' AS remaining_estimate,
            fields->'timetracking'->>'timeSpentSeconds' AS _time_spent,
            fields->'timetracking'->>'timeSpentSeconds' AS time_spent,
            fields->'assignee'->>'accountId' AS assignee,
            created,
            fields->'creator'->>'accountId' AS creator,
            fields->'description'->>'content' AS description,
            renderedFields->>'duedate' AS due_date,
            renderedFields->>'environment' AS environment,
            id,
            fields->'issuetype'->>'id' AS issue_type,
            key,
            projectId AS parent_id, --FIX
            fields->'priority'->>'id' AS priority,
            projectKey AS project,
            fields->'reporter'->>'accountId' AS reporter,
            fields->'resolution'->>'id' AS resolution,
            fields->>'resolutiondate' AS resolved,
            fields->'status'->>'id' AS status,
            fields->>'statuscategorychangedate' AS status_category_changed,
            fields->>'summary' AS summary,
            updated,
            fields->>'workratio' AS work_ratio
        FROM
            {{ source('source_jira', 'issues') }}
    )

    SELECT * FROM TMP

{% elif target.type == "bigquery" %}

    WITH TMP AS (
        SELECT
            JSON_EXTRACT(fields, '$.timetracking.originalEstimateSeconds') AS _original_estimate,
            JSON_EXTRACT(fields, '$.timetracking.originalEstimateSeconds') AS original_estimate,
            JSON_EXTRACT(fields, '$.timetracking.remainingEstimateSeconds') AS _remaining_estimate,
            JSON_EXTRACT(fields, '$.timetracking.remainingEstimateSeconds') AS remaining_estimate,
            JSON_EXTRACT(fields, '$.timetracking.timeSpentSeconds') AS _time_spent,
            JSON_EXTRACT(fields, '$.timetracking.timeSpentSeconds') AS time_spent,
            JSON_EXTRACT_SCALAR(fields, '$.assignee.accountId') AS assignee,
            created,
            JSON_EXTRACT_SCALAR(fields, '$.creator.accountId') AS creator,
            JSON_EXTRACT_SCALAR(fields, '$.description.content') AS description,
            JSON_EXTRACT_SCALAR(renderedFields, '$.duedate') AS due_date,
            JSON_EXTRACT_SCALAR(renderedFields, '$.environment') AS environment,
            id,
            JSON_EXTRACT_SCALAR(fields, '$.issuetype.id') AS issue_type,
            key,
            projectId AS parent_id, --FIX
            JSON_EXTRACT_SCALAR(fields, '$.priority.id') AS priority,
            projectKey AS project,
            JSON_EXTRACT_SCALAR(fields, '$.reporter.accountId') AS reporter,
            JSON_EXTRACT_SCALAR(fields, '$.resolution.id') AS resolution,
            JSON_EXTRACT_SCALAR(fields, '$.resolutiondate') AS resolved,
            JSON_EXTRACT_SCALAR(fields, '$.status.id') AS status,
            JSON_EXTRACT_SCALAR(fields, '$.statuscategorychangedate') AS status_category_changed,
            JSON_EXTRACT_SCALAR(fields, '$.summary') AS summary,
            updated,
            JSON_EXTRACT_SCALAR(fields, '$.workratio') AS work_ratio
        FROM
            {{ source('source_jira', 'issues') }}
    )

    SELECT * FROM TMP

{% elif target.type == "snowflake" %}

    WITH TMP AS (
        SELECT
            fields:"timetracking"::"originalEstimateSeconds" AS _original_estimate,
            fields:"timetracking"::"originalEstimateSeconds" AS original_estimate,
            fields:"timetracking"::"remainingEstimateSeconds" AS _remaining_estimate,
            fields:"timetracking"::"remainingEstimateSeconds" AS remaining_estimate,
            fields:"timetracking"::"timeSpentSeconds" AS _time_spent,
            fields:"timetracking"::"timeSpentSeconds" AS time_spent,
            fields:"assignee"::"accountId" AS assignee,
            created,
            fields:"creator"::"accountId" AS creator,
            fields:"description"::"content" AS description,
            renderedFields::"duedate" AS due_date,
            renderedFields::"environment" AS environment,
            id,
            fields:"issuetype"::"id" AS issue_type,
            key,
            projectId AS parent_id, --FIX
            fields:"priority"::"id" AS priority,
            projectKey AS project,
            fields:"reporter"::"accountId" AS reporter,
            fields:"resolution"::"id" AS resolution,
            fields::"resolutiondate" AS resolved,
            fields:"status"::"id" AS status,
            fields::"statuscategorychangedate" AS status_category_changed,
            fields::"summary" AS summary,
            updated,
            fields::"workratio" AS work_ratio
        FROM
            {{ source('source_jira', 'issues') }}
    )

    SELECT * FROM TMP

{%endif%}
