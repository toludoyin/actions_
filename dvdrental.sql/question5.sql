/*
5.
How would you go about predicting how much the store will make in rentals if a movie starred Ben Willis and Angela
Witherspoon?
*/


with staffs as (
select
ss.staff_id,
ss.store_id,
initcap(first_name||' '||last_name) as staff_first_last_name,
r.rental_id,
inventory_id,
amount
from staff ss
left join rental r using (staff_id)
left join payment using (rental_id)
),

actors as (
select
actor_id,
film_id,
initcap(ac.first_name||' '||ac.last_name) as actor_first_last_name,
inventory_id
from actor ac
left join film_actor fa using (actor_id)
left join inventory using (film_id)
),

joint as (
select *
from staffs
left join actors using (inventory_id)
where actor_first_last_name in ('Ben Willis', 'Angela
Witherspoon')
)

select
store_id,
--film_id,
rental_id,
actor_first_last_name,
amount
from joint
where amount is not null
order by 2