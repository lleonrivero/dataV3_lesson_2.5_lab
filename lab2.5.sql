## Lab | SQL Queries - Lesson 2.5 ##

-- 1. Select all the actors with the first name ‘Scarlett’.
SELECT first_name, last_name FROM actor 
WHERE first_name = 'Scarlett';

-- 2. How many films (movies) are available for rent and how many films have been rented?
DESC film;
DESC inventory;
SELECT COUNT(*) AS 'Available titles' FROM sakila.film ; -- 1000 titles available
SELECT COUNT(*) AS 'Inventory' FROM sakila.inventory; -- 4581 films in inventory (one film can have multiple physical copies) 
DESC rental;
SELECT COUNT(rental_date) AS 'Rentals to date' FROM sakila.rental; -- 16046 rentals so far
SELECT COUNT(return_date) AS 'Returns to date' FROM sakila.rental; -- 15861 films returned
SELECT (COUNT(rental_date) - COUNT(return_date)) AS 'Current rentals' FROM sakila.rental; -- 185 films rented at the moment

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
DESC film;
SELECT MAX(length) AS 'max_duration' FROM sakila.film; -- 185 min.
SELECT MIN(length) AS 'min_duration' FROM sakila.film; -- 46 min.

-- 4. What's the average movie duration expressed in format (hours, minutes)? -- Not sure how to convert this in a clean way. 
SELECT ROUND(avg(length)) AS 'avg_duration' FROM sakila.film;
SELECT concat(floor((AVG(length))/60),":",round((AVG(length))%60,0)) AS "average_length" 
from sakila.film;


-- 5. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT(last_name)) FROM sakila.actor; -- 121

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT * FROM sakila.rental;
SELECT DATEDIFF(MAX(last_update), MIN(rental_date)) AS 'Operating time (in days)' FROM sakila.rental; -- Output is 5312. See NOTE below.

-- NOTE: My Sakila database includes 2 extra rows that are not present in other Sakila databases. 
-- That is why the difference between MAX(last_update) and MIN(rental_date) is different. But the code is correct. 

-- 7. Show rental info with additional columns month and weekday. Get 20 results. -- SUBSTR(string, start, length)
SELECT * FROM sakila.rental;
SELECT *, SUBSTR(rental_date, 1,4) AS 'Year', SUBSTR(rental_date, 6,2) AS 'Month', SUBSTR(rental_date, 9, 2) AS 'Weekday' FROM sakila.rental
LIMIT 20;
SELECT *, DATE_FORMAT(CONVERT(LEFT(rental_date,4),date), '%d-%m-%Y') AS 'issued_date' FROM sakila.rental;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, SUBSTR(rental_date, 1,4) AS 'Year', SUBSTR(rental_date, 6,2) AS 'Month', SUBSTR(rental_date, 9, 2) AS 'Weekday' FROM sakila.rental
LIMIT 20;

-- 9. Get release years.
SELECT title AS 'Title', release_year AS 'Release year' FROM film; 
SELECT DISTINCT(release_year) FROM film; -- All films where released on the same year: 2006.

-- 10 .Get all films with ARMAGEDDON in the title.
SELECT title AS 'Title' FROM sakila.film WHERE title LIKE '%ARMAGEDDON%';

-- 11. Get all films which title ends with APOLLO.
SELECT * FROM sakila.film;
SELECT title, RIGHT(title, 6) AS 'Ending' FROM sakila.film
WHERE title LIKE '%APOLLO'; 

-- 12. Get 10 the longest films.
SELECT title, length FROM sakila.film 
ORDER BY length DESC
LIMIT 10; 

-- 13. How many films include Behind the Scenes content?
SELECT DISTINCT(special_features) FROM sakila.film;
SELECT count(*) AS 'Behind the scenes' FROM sakila.film
WHERE special_features LIKE ('%Behind the scenes%'); -- Total of 538 films

