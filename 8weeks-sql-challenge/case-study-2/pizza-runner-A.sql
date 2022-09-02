/*
A. Pizza Metrics
-----------------
1.How many pizzas were ordered?
2. How many unique customer orders were made?
3. How many successful orders were delivered by each runner?
4. How many of each type of pizza was delivered?
5.How many Vegetarian and Meatlovers were ordered by each customer?
6. What was the maximum number of pizzas delivered in a single order?
7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
8. How many pizzas were delivered that had both exclusions and extras?
9. What was the total volume of pizzas ordered for each hour of the day?
10. What was the volume of orders for each day of the week?

NOTE: A.1, A.2... IMPLIES ANSWER1, ANSWER2.....
*/

-- ANSWERS TO QUESTION
select
count(pizza_id) as total_pizzas_ordered,    -- A. 1
count(distinct customer_id) as unique_customers   -- A. 2
from pizza_runner.customer_orders


-- A. 3
select runner_id,
count(order_id) as  num_of_orders_delivered
from (
    select *,
    case when Cancellation = 'null'
    or Cancellation is null
    or Cancellation = '' then 0 else 1 end as cancellation2
    from pizza_runner.runner_orders
) as successful_orders
where cancellation2 = 0
group by 1
order by 1


-- A. 4
with pizza_types as (
    select *,
    case when Cancellation = 'null'
    or Cancellation is null
    or Cancellation = '' then 0 else 1 end as cancellation2
    from pizza_runner.runner_orders ro
    join pizza_runner.customer_orders co using(order_id)
left join pizza_runner.pizza_names pn on co.pizza_id = pn.pizza_id
)
select
pizza_name,
count(order_id) as num_of_orders
from pizza_types
where cancellation2 = 0
group by 1
order by 1


-- A. 5




