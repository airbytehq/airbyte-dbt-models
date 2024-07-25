This repo contains dbt packages to work with Airbyte connectors.
At the moment they are in a single repo and it will be only available to use as latest version.
There are some plans to dispatch each source as a single package to become easier to use in your project.
These packages are created and maintained by the Airbyte Community.



dbt run --target postgres --vars '{"target_database": "postgres", "zendesk_database": "postgres"}'

dbt run --target snowflake --vars '{"target_database": "INTEGRATION_TEST_DESTINATION", "zendesk_database": "INTEGRATION_TEST_DESTINATION"}'

dbt run --target bigquery --vars '{"target_database": "dataline-integration-testing", "zendesk_database": "dataline-integration-testing"}'