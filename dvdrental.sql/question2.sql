/*
Question 2.
Show rate of default per staff and per customer, decide how you want to present the information.
A default rate is the percentage of film issued by a staff that has not been returned for an excessive amount of time
*/

select
distinct customer_id,
staff_id,
return_date::date,
rental_date::date,
count(return_date::date)/count(rental_date::date) as default_rate
from rental
where return_date::date is null
group by 1,2,3,4
order by 1

