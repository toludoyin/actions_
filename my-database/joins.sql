/** excercise from datacamp - SELF JOIN
https://campus.datacamp.com/courses/exploratory-data-analysis-in-sql/whats-in-the-database?learningMode=course&ex=9
**/
select company_original.name, title, rank
from company as company_original
left join company as company_parent
on company_original.parent_id = company_parent.id
inner join fortune500
on coalesce(company_original.ticker, company_parent.ticker) = fortune500.ticker
order by rank;