{% if target.type == "postgres" %}

  WITH ab AS (
      SELECT
          account->>'id' AS account_id,
          amount AS amount,
          currency AS currency
      FROM {{ source('source_recurly', 'transactions') }}
  )
  SELECT
      account_id,
      currency,
      SUM(amount) AS amount,
      FALSE AS past_due
  FROM ab
  GROUP BY account_id, currency

{% elif target.type == "snowflake" %}

  WITH ab AS (
      SELECT
          account:id AS account_id,
          amount AS amount,
          currency AS currency
      FROM {{ source('source_recurly', 'transactions') }}
  )
  SELECT
      account_id,
      currency,
      SUM(amount) AS amount,
      FALSE AS past_due
  FROM ab
  GROUP BY account_id, currency

{% elif target.type == "bigquery" %}

  WITH ab AS (
      SELECT
          JSON_EXTRACT_SCALAR(account, '$.id') AS account_id,
          amount AS amount,
          currency AS currency
      FROM {{ source('source_recurly', 'transactions') }}
  )
  SELECT
      account_id,
      currency,
      SUM(amount) AS amount,
      FALSE AS past_due
  FROM ab
  GROUP BY account_id, currency

{% endif %}
