-- DATACAMP LEARNING @ https://campus.datacamp.com/courses/functions-for-manipulating-data-in-postgresql/full-text-search-and-postgressql-extensions?ex=1

-- REPLACE function
select
  -- Replace whitespace in the film title with an underscore
  replace(title, ' ',  '_') as title
from film;

-- Truncate strings
select
  -- Select the first 50 characters of description
  left(description, 50) as short_desc
from film as f;

-- SUBSTRINGS (Extract substrings from text data)
select
  -- Select only the street name from the address table
  substring(address from position(' ' in address)+1 for char_length(address))
from address;

-- Combining functions for string manipulation
select
  -- Extract the characters to the left of the '@'
  left(email, position('@' in email)-1) as username,
  -- Extract the characters to the right of the '@'
  substring(email from position('@' in email)+1 for char_length(email)) as domain
from customer;

-- PADDING function (lpad, rpad and lenght function)
-- Concatenate the padded first_name and last_name
select
    rpad(first_name, length(first_name)+1) || last_name as full_name
from customer;

-- Concatenate the first_name and last_name
select
    first_name || lpad(last_name, length(last_name)+1) as full_name
from customer;

-- Concatenate the first_name and last_name
select
    rpad(first_name, length(first_name)+1) || rpad(last_name, length(last_name)
    +2, ' <') || rpad(email, length(email)+1, '>') as full_email
from customer;

-- TRIM function
select
  concat(upper(name), ': ', title) as film_category,
  -- Truncate the description remove trailing whitespace
  trim(left(description, 50)) as film_desc
from film as f
inner join film_category as fc on  f.film_id = fc.film_id
inner join category as c on fc.category_id = c.category_id;

-- PUTTING IT TOGETHER
select
    upper(c.name) || ': ' || f.title as film_category,
    -- Truncate the description without cutting off a word
    left(description, 50 -
        -- Subtract the position of the first whitespace character
        position(
            ' ' in reverse(left(description, 50))
        )
    ) as truncated_description
from film as f
inner join film_category as fc on f.film_id = fc.film_id
inner join category as c on fc.category_id = c.category_id;