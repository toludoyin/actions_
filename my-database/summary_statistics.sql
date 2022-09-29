-----------------------------------------------
-- SUMMARY STATISTICS IN SQL FOR NUMERICAL DATA
-----------------------------------------------

-- MEAN AND MEDIAN
select
round(avg(rental_rate), 2) as avg_rental_rate,
percentile_cont(0.5) within group (order by rental_rate) as median_rental_rate  -- note: 0.5 stands as the 50th percentile
from film;

-- MINIMUM, MAXIMUM, RANGE, STANDARD DEVIATION AND VARIANCE
select
min(rental_rate) as min_rental_rate,
max(rental_rate) as min_rental_rate,
max(rental_rate) - min(rental_rate) as range_rental_rate,
round(stddev(rental_rate),2) as stddev_rental_rate,
round(variance(rental_rate),2) as variance_rental_rate
from film;

-- Q1, Q3 AND IQR
select
percentile_cont(0.25) within group (order by rental_rate) as q1,
percentile_cont(0.75) within group (order by rental_rate) as q3,
percentile_cont(0.75) within group (order by rental_rate) -
percentile_cont(0.25) within group (order by rental_rate) as iqr
from film;

-- SKEWNESS
-- Note: there is no direct function to calculate this, but since skewness = 3 * (mean-median) / standard_deviation
select round(3 * (avg_rental_rate - median_rental_rate)::numeric/ stddev_rental_rate, 2) as skewness
from (
    select
    avg(rental_rate) as avg_rental_rate,
    percentile_cont(0.5) within group (order by rental_rate) as median_rental_rate,
    stddev(rental_rate) as stddev_rental_rate
    from film
    ) as skew;

-- PUTING IT ALL TOGETHER
with recursive summary_stat as (
select
round(avg(rental_rate), 2) as avg_rental_rate,
percentile_cont(0.5) within group (order by rental_rate) as median_rental_rate,
min(rental_rate) as min_rental_rate,
max(rental_rate) as max_rental_rate,
max(rental_rate) - min(rental_rate) as range_rental_rate,
round(stddev(rental_rate),2) as stddev_rental_rate,
round(variance(rental_rate),2) as variance_rental_rate,
percentile_cont(0.25) within group (order by rental_rate) as q1,
percentile_cont(0.75) within group (order by rental_rate) as q3,
percentile_cont(0.75) within group (order by rental_rate) -
percentile_cont(0.25) within group (order by rental_rate) as iqr
from film
),
row_summary_stat as (
	select 1 as no, 'mean' as statistic, avg_rental_rate as value from summary_stat union
	select 2, 'median', median_rental_rate from summary_stat union
	select 3, 'minimum', min_rental_rate from summary_stat union
	select 4, 'maximum', max_rental_rate from summary_stat union
	select 5, 'range', range_rental_rate from summary_stat union
	select 6, 'standard deviation', stddev_rental_rate from summary_stat union
	select 7, 'variance', variance_rental_rate from summary_stat union
	select 8, 'Q1', q1 from summary_stat union
	select 9, 'Q3', q3 from summary_stat union
	select 10, 'IQR', iqr from summary_stat union
	select 11, 'skewness', round(3 * (avg_rental_rate-median_rental_rate)::numeric/ stddev_rental_rate, 2) as skewness from summary_stat
)
select *
from row_summary_stat
order by no


-------------------------------------------------
-- SUMMARY STATISTICS IN SQL FOR CATEGORICAL DATA
-------------------------------------------------

-- MODE
select
mode() within group (order by title) as mode
from film