# Snapchat Marketing Airbyte dbt Package

---

- This package contains dbt models to work with Airbyte Snapchat Ads connector.
- The package is compatible with latest version of Airbyte Snapchat Ads connector.
- Currently, it is limited to creating transformations compatible with [Fivetran's modeling dbt package](https://github.com/fivetran/dbt_snapchat_ads/tree/main).
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
  airbyte_schema: "airbyte_dbt_snapchat_ads"
```

**`packages.yml`**

```yaml
packages:
  - git: "https://github.com/airbytehq/airbyte-dbt-models.git"
    subdirectory: "connectors/source_snapchat_marketing"
```

After you can run `dbt tests` or `dbt docs generate` to have a preview of Airbyte output data.

### Fivetran Snapchat Marketing Modeling dbt package

This package transforms Airbyte connector output data, making it compatible with Fivetran's Snapchat Marketing dbt package. You can check the analytical models Fivetran creates [here](https://github.com/fivetran/dbt_snapchat_ads/tree/main?tab=readme-ov-file#-what-does-this-dbt-package-do). The link also provides information about how the package works and what is configurable.

Create the require files to use Airbyte and Fivetran dbt packages:

**`packages.yml`**

```yaml
packages:
  - git: "https://github.com/airbytehq/airbyte-dbt-models.git"
    subdirectory: "connectors/source_snapchat_marketing"

  - package: fivetran/snapchat_ads
    version: [">=0.5.0", "<0.6.0"]
```

This is a default variable definition you must configure to have the models created.

**`dbt_project.yml`**

```yaml
vars:
  # Required by Airbyte dbt model
  using_fivetran_model: True
  airbyte_database: "airbyte_db_default"
  airbyte_schema: "airbyte_dbt_snapchat_marketing"

  # Required by Fivetran dbt model
  snapchat_ads_database: "airbyte_db_default"
  snapchat_ads_schema: "dbt_source_snapchat_marketing"
```

Run:

```shell
dbt run --model +source_snapchat_marketing
dbt run --model +snapchat_ads

```

---

## :package: Package Maintenance

- This package is maintained by the Airbyte Community.
- You can contribute any time please read the Contributing Guidelines or enter the Airbyte Slack Channel `#airbyte-dbt-packages`
