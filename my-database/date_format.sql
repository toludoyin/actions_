-- date_trunc()
select
date_trunc('day', rental_date) as r_date
from rentals;

-- generate series
select generate_series(start, end, step);

-- datacamp (https://campus.datacamp.com/courses/exploratory-data-analysis-in-sql/working-with-dates-and-timestamps?ex=12&learningMode=course)
-- Bins from Step 1
WITH bins AS (
	 SELECT generate_series('2016-01-01',
                            '2018-01-01',
                            '6 months'::interval) AS lower,
            generate_series('2016-07-01',
                            '2018-07-01',
                            '6 months'::interval) AS upper),
-- Daily counts from Step 2
     daily_counts AS (
     SELECT day, count(date_created) AS count
       FROM (SELECT generate_series('2016-01-01',
                                    '2018-06-30',
                                    '1 day'::interval)::date AS day) AS daily_series
            LEFT JOIN evanston311
            ON day = date_created::date
      GROUP BY day)
-- Select bin bounds
SELECT lower,
       upper,
       -- Compute median of count for each bin
       percentile_disc(0.25) WITHIN GROUP (ORDER BY lower) AS median
  -- Join bins and daily_counts
  FROM bins
       LEFT JOIN daily_counts
       -- Where the day is between the bin bounds
       ON day = lower
          AND day < upper
 -- Group by bin bounds
 GROUP BY lower, upper
 ORDER BY lower;

-- Create lower and upper bounds of bins
select generate_series(2200, 3100, 50) as lower,
       generate_series(2205, 3105, 50) as upper;