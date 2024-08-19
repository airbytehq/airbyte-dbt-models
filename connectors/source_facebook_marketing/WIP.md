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

- staging/tmp: union multiple accounts for each stream
- staging: rename, cast and simple conditionnals on unions
- macros: cast and rename raw columns

Next steps are:

- [x] find the missing fields at the creative level
- [x] replace specific database functions to cross-database macros, especially json functions (@marcosmarxm I found it in fivetran_utils as it does not exists in core)
- [x] use the sources created by Airbyte
- [x] test the Fivetran analytical model and solve bugs
- [ ] final QA
- [ ] (restore the ability to union same-level tables accros databases or schemas)

## Step 3: Write instructions

- [ ] update the documentation (model yaml files + README)
