# Recharge Airbyte dbt Package

---

- This package contains dbt models to work with Airbyte Recharge connector.
- The package is compatible with latest version of Airbyte Recharge connector.
- Currently, it is limited to creating transformations compatible with [Fivetran's modeling dbt package](https://github.com/fivetran/dbt_recharge/tree/main).
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
  airbyte_schema: "airbyte_dbt_source_recharge"
```

**`packages.yml`**

```yaml
packages:
  - git: "https://github.com/airbytehq/airbyte-dbt-models.git"
    subdirectory: "connectors/source_recharge"
```

After you can run `dbt tests` or `dbt docs generate` to have a preview of Airbyte output data.

### Fivetran Recharge Modeling dbt package

This package transforms Airbyte connector output data, making it compatible with Fivetran's Recharge dbt package. You can check the analytical models Fivetran creates [here](https://github.com/fivetran/dbt_recharge/tree/main?tab=readme-ov-file#-what-does-this-dbt-package-do). The link also provides information about how the package works and what is configurable.

Create the require files to use Airbyte and Fivetran dbt packages:

**`packages.yml`**

```yaml
packages:
  - git: "https://github.com/airbytehq/airbyte-dbt-models.git"
    subdirectory: "connectors/source_recharge"

  - package: fivetran/recharge
    version: [">=0.16.0", "<0.17.0"]
```

This is a default variable definition you must configure to have the models created.

**`dbt_project.yml`**

```yaml
vars:
  # Required by Airbyte dbt model
  using_fivetran_model: True
  airbyte_database: "airbyte_db_default"
  airbyte_schema: "airbyte_dbt_recharge"

  # Required by Fivetran dbt model
  recharge_database: "airbyte_db_default"
  recharge_schema: "airbyte_dbt_recharge"

  recharge__one_time_product_enabled: true # Disables if you do not have the ONE_TIME_PRODUCT table. Default is True.
  recharge__charge_tax_line_enabled: true # Disables if you do not have the CHARGE_TAX_LINE table. Default is True.
  recharge__checkout_enabled: false # Enables if you do have the CHECKOUT table. Default is False.

  recharge__standardized_billing_model_enabled: false # false by default.

  recharge__using_orders: true # default is true, which will use the `orders` version of the source.

  recharge_first_date: "yyyy-mm-dd"
  recharge_last_date: "yyyy-mm-dd"

  recharge_address_identifier: "addresses"
  recharge_address_discounts_identifier: "addresses"
  recharge_address_shipping_line_identifier: "addresses"
  recharge_charge_identifier: "charges" 
  recharge_charge_line_item_identifier: "charges"
  recharge_charge_order_attribute_identifier: "charges"  
  recharge_charge_shipping_line_identifier: "charges"  
  recharge_charge_tax_line_identifier: "charges"  
  recharge_customer_identifier: "customers" 
  recharge_discount_identifier: "discounts" 
  recharge_one_time_product_identifier: "onetimes" 
  recharge_order_identifier: "orders"
  recharge_order_line_item_identifier: "orders" 
  recharge_subscription_identifier: "subscriptions" 
  recharge_subscription_history_identifier: "subscriptions" 
```

You need to run the models in steps:

```shell
dbt run --model +source_recharge # create tables needed by Fivetran from Airbyte
dbt run --model +recharge_source # staging tables
dbt run --model +recharge # final analytical model.
```

---

## :package: Package Maintenance

- This package is maintained by the Airbyte Community.
- You can contribute any time please read the Contributing Guidelines or enter the Airbyte Slack Channel `#airbyte-dbt-packages`.
