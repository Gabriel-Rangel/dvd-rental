-- List the four actors (name and last name) who filmed the most movies in the last year

with base as (
	select
		count(fa.actor_id) as quantity,
		fa.actor_id
	 from 
	 	film fi
	 left join
		film_actor fa on fi.film_id = fa.film_id  
	 left join 
	 	actor ac on fa.actor_id = ac.actor_id
	 where
	 	fi.release_year = 2021
	 group by
	 	fa.actor_id
)
select 
	base.quantity as num_films,
	ac.first_name,
	ac.last_name
from
	base 
join
	actor ac on base.actor_id = ac.actor_id 
order by 
	num_films desc
limit 4

