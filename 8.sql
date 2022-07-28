-- Count the number of customers by country

select
	count(customer_id) as num_customer,
	country
from
	customer cu
join
	address ad on cu.address_id = ad.address_id 
join 
	city ci on ad.city_id = ci.city_id 
join 
	country co on ci.country_id = co.country_id 
group by 
	country
order by 
	num_customer desc

	