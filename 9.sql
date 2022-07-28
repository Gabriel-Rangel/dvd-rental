-- Number and average of films by language in each category

with base as (
    -- counting the number of films by language in each category
	select
		count(f.film_id) as num_films,
		l.name as language,
		c.name as category
	from
		film f
	right join
		language l on f.language_id = l.language_id
	left join
		film_category fc on f.film_id = fc.film_id 
	left join 
		category c on fc.category_id = c.category_id 
	group by 
		 category, language
)
select
	coalesce(category, 'There is no films for this language in any category'), -- if there is no films for this language in any category, show the message "There is no ..."
	language,
	num_films,
	coalesce(num_films/nullif(sum(num_films),0),0)*100 as "percentage(%)" -- average of films by language in each category, as the main grouping is by category and just there is english films, percentage result is always 100%
from 
	base b
group by
	category, language, num_films
order by 
	language