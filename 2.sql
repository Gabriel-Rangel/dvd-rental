-- List the four actors (name and last name) who filmed the most movies in the last year

-- PS: As there is no movies released in the last year (2021), the query will return an empty result. So, on line 16 I filtered by the year 2006 based on release_year collumn.

with base as (
	-- listing the actors_id and the number of movies they filmed in the specified year
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
	 	fi.release_year = 2006 -- filtering by the year 2006 and not last year (2021)
	 group by
	 	fa.actor_id
)
-- selecting just the four actors with the highest quantity of movies filmed in the specified year by 'limit 4' clause
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

