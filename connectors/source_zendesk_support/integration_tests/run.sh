#!/bin/bash

export DBT_VARS="$(cat vars | sed "s/\$AB_DB/TESTING/g")"
# export DBT_VARS="{airbyte_database: dataline-integration-testing, zendesk_database: dataline-integration-testing}"
poetry run dbt deps
poetry run dbt run --target bigquery --full-refresh --vars "$DBT_VARS"
