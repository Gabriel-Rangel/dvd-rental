-- List the three clients (name, last name and date of creation) that rented the most movies and the three that rented the least.

with less as (
    -- selecting the 3 clients that rented less movies
    select 
        count(i.film_id) as num_films,
        c.customer_id,
        c.first_name,
        c.last_name,
        c.create_date,
        'less' as quantity -- collumn to differentiate between less and more clients
    from 
        rental r
    join
        customer c on r.customer_id = c.customer_id 
    join 
        inventory i on r.inventory_id = i.inventory_id 
    group by
        c.customer_id, c.first_name, c.last_name, c.create_date
    order by 
        num_films 
    limit 3
),
more as (
    -- selecting the top 3 clients that rented the most movies
    select 
        count(i.film_id) as num_films,
        c.customer_id,
        c.first_name,
        c.last_name,
        c.create_date,
        'more' as quantity -- collumn to differentiate between less and more clients
    from 
        rental r
    join
        customer c on r.customer_id = c.customer_id 
    join 
        inventory i on r.inventory_id = i.inventory_id 
    group by
        c.customer_id, c.first_name, c.last_name, c.create_date
    order by 
        num_films desc
    limit 3
)
-- selecting the specified columns with the quantity collumn as well and union both CTEs with union all to get the full result
select 
    first_name,
    last_name,
    create_date,
    quantity
from 
    more
union all
select 
    first_name,
    last_name,
    create_date,
    quantity
from 
    less