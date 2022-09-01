/*
--------------------
CASE STUDY QUESTIONS
--------------------
1. What is the total amount each customer spent at the restaurant?
2. How many days has each customer visited the restaurant?
3. What was the first item from the menu purchased by each customer?
4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

BONUS QUESTIONS
1. join all the things
2. rank all the things
*/

-- ANSWERS TO QUESTIONS
select
distinct s.customer_id,
sum(m.price) as total_amount,      --QUESTION 1
count(distinct s.order_date) as num_of_visit_days   --QUESTION 2
from dannys_diner.sales s
join dannys_diner.menu m using(product_id)
group by 1


-- QUESTION 3
select * from
(
    select
    order_date,
    customer_id,
    product_name,
    row_number() over(partition by customer_id order by order_date) as row_num
    from dannys_diner.sales s
    join dannys_diner.menu m using(product_id)
    order by order_date, customer_id
) as first_order
where row_num = 1


-- QUESTION 4
select
m.product_name,
sum(m.price) as total_price,
count(*) as num_of_times_purchase
from dannys_diner.sales s
join dannys_diner.menu m using(product_id)
group by 1
order by 2 desc
limit 1


-- QUESTION 5
select * from
(
    select
    customer_id,
    product_name,
    count(product_name) as num_of_times_product_ordered,
    row_number() over(partition by customer_id order by count(product_name) desc) as row_num
    from dannys_diner.sales s
    join dannys_diner.menu m using(product_id)
    group by 1,2
    order by 1
) as popular
where row_num = 1


-- QUESTION 6
select * from
(
    select
    customer_id,
    product_name,
    join_date,
    s.order_date,
    count(product_name) as num_of_times_product_ordered,
    row_number() over(partition by customer_id order by order_date) as row_num
    from dannys_diner.sales s
    join dannys_diner.menu m using(product_id)
    left join  dannys_diner.members me using(customer_id)
    where me.join_date < s.order_date
    group by 1, 2, 3, 4
    order by 1
) as popular
where row_num = 1


-- QUESTION 7
select * from
(
    select
    customer_id,
    product_name,join_date, s.order_date,
    count(product_name) as num_of_times_product_ordered,
    row_number() over(partition by customer_id order by order_date desc) as row_num
    from dannys_diner.sales s
    join dannys_diner.menu m using(product_id)
    left join  dannys_diner.members me using(customer_id)
    where me.join_date > s.order_date
    group by 1,2,3,4
    order by 1
) as popular
where row_num = 1


-- QUESTION 8
select
customer_id,
count(product_id) as num_of_items,
sum(m.price) as total_amount
from dannys_diner.sales s
join dannys_diner.menu m using(product_id)
left join  dannys_diner.members me using(customer_id)
where me.join_date > s.order_date
group by 1
order by 1

-- QUESTION 9


-- QUESTION 10











