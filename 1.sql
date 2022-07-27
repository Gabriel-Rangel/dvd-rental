-- List the five clients who have paid the most for renting DVDs of horror movies

select 
	cus.customer_id, 
	cus.first_name, 
	cus.last_name,
	sum(pay.amount) as amount
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
	cat.name = 'Horror'
group by 
	cus.customer_id, cus.first_name, cus.last_name
order by
	amount desc 
limit 5;