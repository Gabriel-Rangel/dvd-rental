-- List the five clients who have paid the most for renting DVDs of horror movies

select 
	cus.customer_id, 
	cus.first_name, 
	cus.last_name,
	sum(cast(regexp_replace(pay.amount, '[$]', '') as integer)) as amount -- removing the $ sign and casting it to integer before summing the amount.
from 
	customer cus
join
	payment pay on pay.customer_id = cus.customer_id 
join 
	 rental ren on cus.customer_id = ren.customer_id 
join
	inventory inv on ren.inventory_id = inv.inventory_id 
join
	film fil on inv.film_id = fil.film_id 
join 
	film_category fca on fil.film_id = fca.film_id 
join 
	category cat on fca.category_id = cat.category_id 
where 
	cat.name = 'Horror' -- filtering by movie's category 'Horror'
group by 
	cus.customer_id, cus.first_name, cus.last_name -- grouping results by customer
order by
	amount desc -- ordering results by amount paid in descending order
limit 5 -- limiting the results to get the top 5 clients