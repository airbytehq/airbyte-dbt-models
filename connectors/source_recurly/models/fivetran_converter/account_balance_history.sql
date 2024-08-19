with ab as (select
  {{ fivetran_utils.json_extract('account', 'id') }} as account_id,
  amount as amount,
  currency as currency
from {{source('source_recurly', 'transactions')}}
)
select
    account_id,
    currency,
    sum(amount) as amount,
    false as past_due
from ab
group by account_id, currency
