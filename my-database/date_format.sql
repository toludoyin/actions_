-- date_trunc()
select
date_trunc('day', rental_date) as r_date
from rentals;

-- generate series
select generate_series(start, end, step);

-- Create lower and upper bounds of bins
select generate_series(2200, 3100, 50) as lower,
       generate_series(2205, 3105, 50) as upper;