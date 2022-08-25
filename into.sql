
select
customer_id,
dat,
sum(amount) as total_amount
grouping(customer_id) as g1,  --grouping function shows the grouped row
grouping(dat) as g3
into temporary_table
from payment
where customer_id in (1,2,3)
group by rollup (1,2)   --add rows of sum of each customer_id and the sum of all the customers_id
order by 1;

select * from temporary_table