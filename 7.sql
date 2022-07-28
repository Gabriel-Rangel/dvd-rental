-- List the movie that was rented the most for each category.

with base as (
    -- counting the number of film's rentals by category
	select 
		count(fil.film_id) as quantity,
		fil.film_id,
		fil.title,
		cat.name as category,
		dense_rank() over(partition by cat.name order by count(fil.film_id) desc) as ranking -- Ranking of the film by category based on quantity of rentals. If the same quantity of rentals per a particular movie they will receive the same ranking.
	from 
		rental ren
	join
		inventory inv on ren.inventory_id = inv.inventory_id 
	join
		film fil on inv.film_id = fil.film_id 
	join 
		film_category fca on fil.film_id = fca.film_id 
	join 
		category cat on fca.category_id = cat.category_id
	group by 
		fil.film_id, fil.title, cat.name
)
-- just selecting the movies with number 1 in the ranking collumn (each represents the movies with the most rentals per category). As the ranking is based just by the number of rentals, will be categories with more than 1 movie ranking in the same level in case of the ranking is tie.
select
	quantity,	
	title,
	category
from 
	base
where
	ranking = 1