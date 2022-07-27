-- List the number of movies in inventory for each store

select 
	store_id,
	count(film_id) as num_films
from 
	inventory
group by
	store_id