
-- BONUS QUESTIONS
-- Join All The Things

CREATE SCHEMA dannys_diner;
SET search_path = dannys_diner;

CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_name" VARCHAR(6),
  "price" INTEGER,
  "member" VARCHAR(1)
);

INSERT INTO sales
  ("customer_id", "order_date", "product_name", "price", "member")
VALUES
  ('A', '2021-01-01', 'curry', 15, 'N'),
  ('A', '2021-01-01', 'sushi', 10, 'N'),
  ('A', '2021-01-07', 'curry', 15, 'Y'),
  ('A', '2021-01-10', 'ramen', 12, 'Y'),
  ('A', '2021-01-11', 'ramen', 12, 'Y'),
  ('A', '2021-01-11', 'ramen', 12, 'Y'),
  ('B', '2021-01-01', 'curry', 15, 'N'),
  ('B', '2021-01-02', 'curry', 15, 'N'),
  ('B', '2021-01-04', 'sushi', 10, 'N'),
  ('B', '2021-01-11', 'sushi', 10, 'Y'),
  ('B', '2021-01-16', 'ramen', 12, 'Y'),
  ('B', '2021-02-01', 'ramen', 12, 'Y'),
  ('C', '2021-01-01', 'ramen', 12, 'N'),
  ('C', '2021-01-01', 'ramen', 12, 'N'),
  ('C', '2021-01-07', 'ramen', 12, 'N');


select * from dannys_diner.sales


-- Rank All The Things
with rank_all as (
    select *,
    case when (member = 'Y') then rank() over(partition by customer_id order by order_date, member) else null end as ranks
    from dannys_diner.sales
)
select
customer_id,
order_date,
product_name,
price,
member,
case when (ranks is not null) then rank() over(partition by customer_id order by ranks) else null end as ranking
from rank_all
order by customer_id, order_date