-- Determine the first and second biggest fans of each actor 
-- (according to the clients who rented the largest number of movies in which these actors participated).

with customers as (
    -- List the customers and the movies rented.
	select
		film_id,
		c.customer_id,
		concat(first_name, ' ', last_name) as customer_name
	from 
		customer c
	join
		rental r on c.customer_id = r.customer_id 
	join 
		inventory i on r.inventory_id = i.inventory_id
),
actors as (
    -- List the actors and the movies they have been in.
	select
		fa.film_id,
		a.actor_id,
		concat(first_name, ' ', last_name) as actor_name
	from 
		film_actor fa
	join
		actor a on fa.actor_id = a.actor_id
),
actor_per_customer as (
    -- List the actors and the customers who have rented them movies. Also associating the number of customer who have rented movies per actor.
	select 
		actor_id,
		actor_name,
		count(customer_id) as quantity_per_customer,
		customer_id,
		customer_name,
		dense_rank() over(partition by actor_id order by count(customer_id) desc, customer_name) as ranking -- in case of the same number of movies per actor, order by customer name alphabtic order
	from 
		customers c
	join
		actors a on c.film_id = a.film_id
	group by 
		actor_id, actor_name, customer_id, customer_name
)
-- selecting just the first and second biggest fans of each actor
select 
	actor_name,
	customer_name,
	quantity_per_customer 
from
	actor_per_customer 
where 
	ranking < 3
	


