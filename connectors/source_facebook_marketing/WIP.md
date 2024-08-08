# Work in Progress

See instuctions: [here](https://github.com/airbytehq/airbyte-dbt-models/discussions/43)

## Step 1: Identify what streams

[fivetran/dbt_facebook_ads_source sources](https://github.com/fivetran/dbt_facebook_ads_source/blob/main/models/src_facebook_ads.yml)

| Fivetran         | Airbyte      |
| ---------------- | ------------ |
| account_history  | ad_account   |
| ad_history       | ads          |
| ad_set_history   | ad_sets      |
| basic_ad         | ads_insights |
| campaign_history | campaigns    |
| creative_history | ad_creatives |

## Step 2: Identify what column each stream is using

## Step 3: Write instructions
