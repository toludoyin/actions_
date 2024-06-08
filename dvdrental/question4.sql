/*
4.
Show daily, weekly and monthly sales with a periodic total and cumulative total for each period (i.e. daily, weekly and monthly)
 */

--daily
select
date_trunc('day', payment_date) as daily,
sum(amount) as periodic_total,
sum(sum(amount)) over(order by date_trunc('day', payment_date) rows unbounded preceding) as cummulative_total
from payment
group by 1
order by 1

--weekly
select
date_trunc('week', payment_date) as daily,
sum(amount) as periodic_total,
sum(sum(amount)) over(order by date_trunc('week', payment_date) rows unbounded preceding) as cummulative_total
from payment
group by 1
order by 1

--monthly
select
date_trunc('month', payment_date) as daily,
sum(amount) as periodic_total,
sum(sum(amount)) over(order by date_trunc('month', payment_date) rows unbounded preceding) as cummulative_total
from payment
group by 1
order by 1
