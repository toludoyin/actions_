-- analytics function:(lags, lead, first_value, last_value)

create view temp_table as -- save result
with starts as (
select * from payment
left join customer using(customer_id)
),
init_ as (
select
    customer_id, dat,
    initcap(first_name||' '||last_name) as first_last_name, amount, -- string concatenation
    lag(amount) over(order by customer_id),  --previous
    lead(amount) over(order by customer_id),  --next
    amount - lag(amount) over(order by customer_id) as amount_diff,
    lead(amount) over(order by customer_id) - amount as amount_diff_with_lead
from starts
)
select
    distinct customer_id, first_last_name,
    first_value(dat) over(partition by customer_id order by dat), --shows earliest value
    last_value(dat) over(order by customer_id),  --shows current value
    nth_value(dat, 5) over(order by customer_id)  --fill the 5th value from dat column into a new column
from init
group by 1,2,dat
order by 1

select * from temp_table