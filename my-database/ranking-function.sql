-- rank() function
-- dense_rank()
-- row_number() each row gets its unique rank
-- ntile() distribute the row into x number of group

with ranking as (
select
aa.*, fa.*,
rank() over(order by actor_id),    --gives a gap in numbering
dense_rank()  over(order by actor_id desc),  --do not give a gap in numbering
row_number() over(partition by actor_id) as row_number,
ntile(100) over(order by actor_id desc)   --to group value in a column
from actor aa
left join film_actor fa using(actor_id)
order by 1
)
select * from ranking
where row_number =1
offset 20;  --skip first 20 rows