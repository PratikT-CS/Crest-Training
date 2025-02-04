-- Querying Data


-- Select all data from a table

SELECT * FROM movies;

SELECT * FROM actors;


-- Selecting specific columns from a table

SELECT first_name, last_name FROM actors;

SELECT movie_name, movie_lang FROM movies; 


-- Adding Aliases to columns in a table

SELECT first_name AS FirstName FROM actors;

SELECT first_name AS "First Name" FROM actors;

SELECT 
	movie_name AS "Movie Name", 
	movie_lang AS "Language"
FROM movies;


-- Using SELECT statement for expressions

SELECT first_name || last_name AS "Full Name" FROM actors;

SELECT first_name || ' ' || last_name AS "Full Name" FROM actors;


-- Using ORDER BY to sort records

SELECT * FROM movies ORDER BY release_date ASC;

SELECT * FROM movies ORDER BY release_date; -- By default ASC

SELECT * FROM movies ORDER BY release_date DESC;

-- Multiply Columns 

SELECT * 
FROM movies
ORDER BY
	release_date ASC,
	movie_name DESC
;

SELECT * 
FROM movies
ORDER BY
	movie_name DESC,
	release_date ASC
;


-- Using ORDER BY with alias column name

SELECT
	first_name,
	last_name AS "Surname"
FROM actors
ORDER BY 
	last_name;

SELECT
	first_name,
	last_name AS "Surname"
FROM actors
ORDER BY 
	last_name DESC;

SELECT
	first_name,
	last_name AS "Surname"
FROM actors
ORDER BY 
	"Surname" DESC
;

-- Using ORDER BY to sort rows by expressions

SELECT 
	first_name,
	LENGTH(first_name) AS len
FROM actors
ORDER BY 
	len DESC;


-- Using ORDER BY with column name or column number

SELECT *
FROM actors
ORDER BY 
	first_name ASC,
	date_of_birth DESC
;

SELECT 
	first_name,
	last_name,
	date_of_birth
FROM actors
ORDER BY 
	first_name ASC,
	date_of_birth DESC
;

SELECT 
	first_name,
	last_name,
	date_of_birth
FROM actors
ORDER BY 
	1 ASC,
	3 DESC
;

SELECT 
	last_name,
	first_name,
	date_of_birth
FROM actors
ORDER BY 
	1 ASC,
	3 DESC
;


-- Using ORDER BY with NULL values

-- We use NULLS FIRST OR LAST keywords as preference

SELECT 
	first_name,
	LENGTH(first_name) AS len
FROM actors
ORDER BY 
	len; -- in asc order null values come last by default

SELECT 
	first_name,
	LENGTH(first_name) AS len
FROM actors
ORDER BY 
	len NULLS FIRST;	

--DESC Order 

SELECT 
	first_name,
	LENGTH(first_name) AS len
FROM actors
ORDER BY 
	len DESC; -- in desc order null values come first by default

SELECT 
	first_name,
	LENGTH(first_name) AS len
FROM actors
ORDER BY 
	len DESC NULLS LAST;


-- Using DISTINCT for selecting distinct values

SELECT * FROM movies;

SELECT 
	movie_lang
FROM movies;

SELECT 
	DISTINCT movie_lang
FROM movies; 

SELECT
	 DISTINCT director_id
FROM movies;

SELECT 
	DISTINCT movie_lang, director_id
FROM movies
ORDER BY 1
;





	