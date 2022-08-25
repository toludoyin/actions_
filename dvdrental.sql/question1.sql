/**
Question 1.
Investigate the relationship between staff and film actors.
Show the top 5 actors each staff rented out most often.
**/


	with film_actors as (
    select
    actor_id,
    initcap(ac.first_name||' '||ac.last_name) as actor_first_last_name,
    fa.film_id,
    ff.title,
    ff.description
    from actor ac
    left join film_actor fa using (actor_id)
    left join film ff using (film_id)
     ),

	staff_data as (
    select
	s.staff_id,
	i.film_id,
	initcap(s.first_name||' '||s.last_name) as staff_first_last_name,
	lower(email) as email,
	upper(username) as username
	from staff s
	left join rental r using (staff_id)
	left join inventory i on i.inventory_id = r.inventory_id
	order by 1
    )

    select
    actor_first_last_name,
    staff_first_last_name,
    count(staff_id) as actors_rented_out_most_often
    from film_actors
    join staff_data using (film_id)
    where staff_id = 1
    group by 1,2,staff_id
    order by 3 desc
    limit 5
