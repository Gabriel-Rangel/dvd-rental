-- List the accumulated per day of payments in a month for a client

select 
	customer_id,
	sum(cast(regexp_replace(amount, '[$]', '') as integer)) as amount, -- removing the $ sign and casting it to integer before summing the amount.
	cast(payment_date as date) as payment_date  -- casting timestamp to date
from 
	payment p
--	where customer_id = 1 (if desired to speficify a customer)
group by
	customer_id, payment_date 
order by
	customer_id, amount desc, payment_date 