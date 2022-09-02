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
select
customer_id,
coalesce(count(case when pizza_name='Meatlovers' then order_id end),0) as Meatlovers,
coalesce(count(case when pizza_name='Vegetarian' then order_id end),0) as Vegetarian
from pizza_runner.runner_orders ro
join pizza_runner.customer_orders co using(order_id)
left join pizza_runner.pizza_names pn on co.pizza_id = pn.pizza_id
group by 1
order by 1


--A. 6
select order_id,
count(pizza_id) as num_of_pizzas_delivered
from pizza_runner.customer_orders
group by 1
order by 2 desc


-- A. 7
with cleaned_change_data as (
    select *,
    case when exclusions in ('null', '') or exclusions is null then '0'
    else exclusions end as exclusion,
    case when extras in ('null', '') or extras is null then '0'
    else extras end as extra
    from pizza_runner.customer_orders
    where order_id in
    (
        select distinct order_id
        from (
            select *,
            case when Cancellation is null
            or Cancellation in('null', '') then 0 else 1 end as cancellation2
            from pizza_runner.runner_orders
            ) as successful_pizza
        where cancellation2 = 0
    )
),
new_change_col as (
    select *,
    case when exclusion = '0' and extra = '0' then 0 else 1 end as change
    from cleaned_change_data
    order by 1
)
select
customer_id,
count(order_id) filter (where change::int =0) as pizza_no_changes,
count(order_id) filter (where change::int > 0) as pizza_changes
from new_change_col
group by 1








