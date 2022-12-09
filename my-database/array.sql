-- learning from https://campus.datacamp.com/courses/functions-for-manipulating-data-in-postgresql/overview-of-common-data-types?ex=11

-- Select the title and special features column
select
  title,
  special_features
from film
-- Use the array index of the special_features column
where special_features[2] = 'Deleted Scenes';

-- using any() with an array
select
  title,
  special_features
from film
-- Modify the query to use the ANY function
where 'Trailers' = ANY(special_features);

--  searching array with @>
select
  title,
  special_features
from film
-- Filter where special_features contains 'Deleted Scenes'
where special_features @> ARRAY['Deleted Scenes'];