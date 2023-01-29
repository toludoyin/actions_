select
    customer_id, dat, sum(amount) as total_amount
    grouping(customer_id) as g1,  --grouping function shows the grouped row
    grouping(dat) as g3
into temporary_table
from payment
where customer_id in (1,2,3)
group by rollup (1,2)   --add rows of sum of each customer_id and the sum of all the customers_id
order by 1;

select * from temporary_table;

/**
https://campus.datacamp.com/courses/exploratory-data-analysis-in-sql/summarizing-and-aggregating-numeric-data?learningMode=course&ex=13
**/
DROP TABLE IF EXISTS profit80;

CREATE TEMP TABLE profit80 AS
  SELECT sector,
         percentile_disc(0.8) WITHIN GROUP (ORDER BY profits) AS pct80
    FROM fortune500
   GROUP BY sector;

-- Select columns, aliasing as needed
SELECT title, fortune500.sector, profits, profits/pct80 AS ratio
-- What tables do you need to join?
  FROM fortune500
       LEFT JOIN profit80
-- How are the tables joined?
       ON fortune500.sector=profit80.sector
-- What rows do you want to select?
 WHERE profits > pct80;