-- List the Top three vendors (staff) for each of the stores.

with base as (
	select 
		sta.staff_id,
		sta.store_id,
		sum(cast(regexp_replace(amount, '[$]', '') as integer)) as amount,  -- removing the $ sign and casting it to integer before summing the amount.
		dense_rank() over(partition by sta.store_id ORDER by sum(cast(regexp_replace(amount, '[$]', '') as integer)) DESC) AS ranking -- Ranking staffs by store based in amount.
	from 
		staff sta
	join
		payment pay on sta.staff_id = pay.staff_id 
	join 
		store sto on sta.store_id = sto.store_id 
	group by 
		sta.staff_id, sta.store_id
	order by 
		store_id, amount desc
)
-- selecting the 3 top staffs based on ranking
select
	*
from 
	base
where 
	ranking < 4


