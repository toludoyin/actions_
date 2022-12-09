-- https://campus.datacamp.com/courses/functions-for-manipulating-data-in-postgresql/full-text-search-and-postgressql-extensions?ex=3
-- using tsvector

-- Select the film description as a tsvector
select to_tsvector(description)
from film;