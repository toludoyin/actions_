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

--ANSWERS TO QUESTIONS
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



