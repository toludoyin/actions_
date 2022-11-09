-- over() window function mean "for all rows in the query"
-- partition by multiple column

select
customer_id, amount, maximum_amount_a_customer_paid_to_each_staff
from (
    select payment_id, customer_id, staff_id,
    rental_id, amount, dat,
    max(amount) over(partition by customer_id, staff_id) as maximum_amount_a_customer_paid_to_each_staff,
    max(amount) over(partition by customer_id, staff_id) - amount::numeric as diff_bet_maximum_amount_a_customer_paid_to_each_staff_and_the_exact_amount,
    sum(amount) over(partition by customer_id, staff_id) as amount_a_customer_paid_to_each_staff,
    count(staff_id) over(partition by customer_id) as no_of_times_a_customer_made_payment_to_both_staffs
    from payment
    order by 2
)inner_query
where amount = maximum_amount_a_customer_paid_to_each_staff; --this filters the value in the window function in corresponding to the main value

/**
window_frames
general syntax: rows between lower_bound and upper_bound
unbounded preceeding- first possible row
current row
unbounded following- last possible row
**/

select
initcap(concat(first_name, ' ', last_name)) as first_last_name,
customer_id, amount,
sum(amount) over(order by customer_id rows unbounded preceding) as cum_amount,
sum(amount) over(order by customer_id range unbounded preceding) as cum_amount2
from customer
join payment using (customer_id)
order by 4;