# Google Ads Airbyte dbt Package

---

- This package contains dbt models to work with Airbyte Google Ads connector.
- The package is compatible with latest version of Airbyte Google Ads connector.
- Currently, it is limited to creating transformations compatible with [Fivetran's modeling dbt package](https://github.com/fivetran/dbt_google_ads/tree/main).
- In the future, specific models will be applied directly to Airbyte connector output. If you have an idea or want to propose an analytical model for this source, please refer to the contributing guide, which explains how to propose a new transformation model.
- This package was tested with BigQuery, Snowflake, and Postgres data warehouses.

---

## 🎯 Intructions how to use

### Airbyte dbt Package

For now Airbyte dbt packages aren't versioned. You must configure using git and subdirectory. For now there isn't any transformation model directly applied to this package. But you can generate docs and tests with dbt.

Create the following files:

**`dbt_project.yml`**

```yaml
vars:
  using_fivetran_model: False
  airbyte_database: "airbyte_db_default"
  airbyte_schema: "airbyte_dbt_google_ads"
```

**`packages.yml`**

```yaml
packages:
  - git: "https://github.com/airbytehq/airbyte-dbt-models.git"
    subdirectory: "connectors/source_google_ads"
```

After you can run `dbt tests` or `dbt docs generate` to have a preview of Airbyte output data.

### Fivetran Google Ads Modeling dbt package

This package transforms Airbyte connector output data, making it compatible with Fivetran's Google Ads dbt package. You can check the analytical models Fivetran creates [here](https://github.com/fivetran/dbt_google_ads/tree/main?tab=readme-ov-file#-what-does-this-dbt-package-do). The link also provides information about how the package works and what is configurable.

Create the require files to use Airbyte and Fivetran dbt packages:

**`packages.yml`**

```yaml
packages:
  - git: "https://github.com/airbytehq/airbyte-dbt-models.git"
    subdirectory: "connectors/source_google_ads"

  - package: fivetran/google_ads
    version: [">=0.5.0", "<0.6.0"]
```

This is a default variable definition you must configure to have the models created.

**`dbt_project.yml`**

```yaml
vars:
  # Required by Airbyte dbt model
  using_fivetran_model: True
  airbyte_database: "airbyte_db_default"
  airbyte_schema: "airbyte_dbt_google_ads"

  # Required by Fivetran dbt model
  google_ads_database: "airbyte_db_default"
  google_ads_schema: "dbt_source_google_ads"

  google_ads__account_history_identifier: "account_history"
  google_ads__account_stats_identifier: "account_stats"
  google_ads__ad_history_identifier: "ad_history"
  google_ads__ad_stats_identifier: "ad_stats"
  google_ads__campaign_history_identifier: "campaign_history"
  google_ads__campaign_stats_identifier: "campaign_stats"
  google_ads_ad_group_criterion_history_identifier: "group_criterion_history"
  google_ads__ad_group_history_identifier: "group_history"
  google_ads__ad_group_stats_identifier: "group_stats"
  google_ads__keyword_stats_identifier: "keyword_stats"
```

After run `dbt run`, you can see the models being created.

---

## :package: Package Maintenance

- This package is maintained by the Airbyte Community.
- You can contribute any time please read the Contributing Guidelines or enter the Airbyte Slack Channel `#airbyte-dbt-packages`
