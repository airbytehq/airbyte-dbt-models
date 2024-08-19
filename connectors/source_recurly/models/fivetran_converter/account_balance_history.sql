WITH ab AS (SELECT
  {{ fivetran_utils.json_extract('account', 'id') }} AS account_id,
  amount AS amount,
  currency AS currency
FROM {{source('source_recurly', 'transactions')}}
)
SELECT
    account_id,
    currency,
    sum(amount) as amount,
    false as past_due
FROM ab
GROUP BY account_id, currency
