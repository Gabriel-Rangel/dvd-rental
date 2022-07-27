with more as (
    select 
        count(i.film_id) as num_films,
        c.customer_id,
        c.first_name,
        c.last_name,
        c.create_date,
        'less' as quantity
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
less as (
    select 
        count(i.film_id) as num_films,
        c.customer_id,
        c.first_name,
        c.last_name,
        c.create_date,
        'more' as quantity
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
select 
    *
from 
    more
union all
select 
    *
from 
    less