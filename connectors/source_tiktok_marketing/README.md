# Tiktok Marketing Airbyte dbt Package

---

> [!WARNING]  
> This model was tested and only work with Bigquery.

What it includes:

- This package contains dbt models to work with Airbyte Tiktok Marketing connector.
- The package is compatible with latest version of Airbyte Tiktok Marketing connector.
- Currently, it is limited to creating transformations compatible with [Fivetran's modeling dbt package](https://github.com/fivetran/dbt_tiktok_ads/tree/main).
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
  airbyte_schema: "airbyte_dbt_tiktok_marketing"
```

**`packages.yml`**

```yaml
packages:
  - git: "https://github.com/airbytehq/airbyte-dbt-models.git"
    subdirectory: "connectors/source_tiktok_marketing"
```

After you can run `dbt tests` or `dbt docs generate` to have a preview of Airbyte output data.

### Fivetran Tiktok Marketing Modeling dbt package

This package transforms Airbyte connector output data, making it compatible with Fivetran's Tiktok Marketing dbt package. You can check the analytical models Fivetran creates [here](https://github.com/fivetran/dbt_tiktok_ads/tree/main?tab=readme-ov-file#-what-does-this-dbt-package-do). The link also provides information about how the package works and what is configurable.

Create the require files to use Airbyte and Fivetran dbt packages:

**`packages.yml`**

```yaml
packages:
  - git: "https://github.com/airbytehq/airbyte-dbt-models.git"
    subdirectory: "connectors/source_tiktok_marketing"

  - package: fivetran/tiktok_ads
    version: [">=0.5.0", "<0.6.0"]
```

This is a default variable definition you must configure to have the models created.

**`dbt_project.yml`**

```yaml
vars:
  # Required by Airbyte dbt model
  using_fivetran_model: True
  airbyte_database: "airbyte_db_default"
  airbyte_schema: "airbyte_dbt_tiktok_marketing"

  # Required by Fivetran dbt model
  tiktok_ads_database: "airbyte_db_default"
  tiktok_ads_schema: "airbyte_dbt_tiktok_marketing"

  tiktok_ads_adgroup_history_identifier: "ad_group_history"
  tiktok_ads_adgroup_report_hourly_identifier: "ad_group_report_hourly"
  tiktok_ads_ad_history_identifier: "ad_history"
  tiktok_ads_ad_report_hourly_identifier: "ad_report_hourly"
  tiktok_ads_advertiser_identifier: "advertiser"
  tiktok_ads_campaign_history_identifier: "campaign_history"
  tiktok_ads_campaign_report_hourly_identifier: "campaign_report_hourly"
```

Run
```shell
dbt run --model +source_tiktok_marketing
dbt run --model +tiktok_ads
```

---

## :package: Package Maintenance

- This package is maintained by the Airbyte Community.
- You can contribute any time please read the Contributing Guidelines or enter the Airbyte Slack Channel `#airbyte-dbt-packages`
