/*
3.
Show the list of 10 most profitable staff (according to the average lifetime profitabiity i.e.
how much they've made per day since employment) [hint: use the last_update field on staff table]
*/

select
staff_id,
initcap(ss.first_name||' '||ss.last_name) as staff_first_last_name,
ss.last_update,
count(last_update) as number_of_days,
sum(amount) as amount,
round(sum(amount)/count(last_update),2) as profit
from staff ss
join payment using(staff_id)
group by 1,2,3
