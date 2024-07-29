#!/bin/bash

export DBT_VARS=$(cat vars | sed "s/\$AB_DB/TESTING/g")
echo "My variable is $DBT_VARS"
poetry run dbt deps
poetry run dbt run --target bigquery --full-refresh --vars "{airbyte_database: dataline-integration-testing, zendesk_database: dataline-integration-testing}"
