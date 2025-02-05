-- 5 Filtering Data

-- Comparison, Logical and Arithmetic operators

-- AND Operator

SELECT * FROM movies;

SELECT * 
FROM movies
WHERE movie_lang = 'English';

SELECT * 
FROM movies
WHERE 
	movie_lang = 'English' 
	AND age_certificate = '18' 
;


-- OR Operator

SELECT *
FROM movies
WHERE 
	movie_lang = 'English'
	OR movie_lang = 'Chinese'
ORDER BY 
	movie_lang
;

SELECT *
FROM movies
WHERE 
	movie_lang = 'English'
	OR age_certificate = '18'
ORDER BY
	movie_lang DESC
;


-- Combining AND, OR operators

SELECT *
FROM movies
WHERE
	movie_lang = 'English'
	OR movie_lang = 'Chinese'
	AND age_certificate = '12'
ORDER BY 
	movie_lang
;

-- using parenthese is nesscary to get correct result and to maintain the order of operators
SELECT *
FROM movies
WHERE
	(movie_lang = 'English'
	OR movie_lang = 'Chinese')
	AND age_certificate = '12'
ORDER BY 
	movie_lang
;


-- Logical Operators

SELECT *
FROM movies
WHERE 
	movie_length > 100
ORDER BY
	movie_length
;

SELECT *
FROM movies
WHERE 
	movie_length < 100
ORDER BY 
	movie_length
;

SELECT * 
FROM movies
WHERE 
	movie_length >= 91
ORDER BY
 	movie_length
;


-- while working with dates take care of the format in which date is stored in database 
-- dd-mm-yyyy or yyyy-mm-dd.
-- here it is yyyy-mm-dd
SELECT *
FROM movies
WHERE 
	release_date >= '2000-01-01'
ORDER BY
	release_date
;


-- Yes we can use logical operator with string values as well 
-- they will work in alphabetic order of first letter
-- here in movie_lang > 'English' means value/string starting with letters after e that is f,g,h....

SELECT *
FROM movies
WHERE 
	movie_lang > 'English'
ORDER BY 
	movie_lang
;

-- here in movie_lang < 'English' means value/string starting with letters before e that is a,b,c,d only.
SELECT * 
FROM movies
WHERE 
	movie_lang < 'English'
ORDER BY
	movie_lang
;

-- here <> not equal to English
-- <> same as using !=
SELECT * 
FROM movies
WHERE 
	movie_lang <> 'English'
ORDER BY
	movie_lang
;



-- Using LIMIT and OFFSET

-- 5 longest films
SELECT *
FROM movies
ORDER BY 
	movie_length DESC
LIMIT 5
;

-- 5 oldest directors
SELECT * 
FROM directors
ORDER BY 
	date_of_birth
LIMIT 5
; 

-- 5 oldest american directors 
SELECT * 
FROM directors
WHERE 
	nationality = 'American'
ORDER BY 
	date_of_birth
LIMIT 5
;
	
-- 5 youngest american directors
SELECT *
FROM directors
WHERE 
	nationality = 'American'
ORDER BY
	date_of_birth DESC
LIMIT 5
;

-- 10 YOUNGEST FEMALE ACTRESS
SELECT * FROM actors;

SELECT *
FROM actors
WHERE 
	gender = 'F'
ORDER BY 
	date_of_birth DESC
LIMIT 10
;


-- 10 most profitable domestic movies

SELECT *
FROM movies_revenues
ORDER BY 
	revenues_domestic DESC NULLS LAST
LIMIT 10
;

-- 10 least profitable domestic movies

SELECT * 
FROM movies_revenues
ORDER BY 
	revenues_domestic
LIMIT 10
;


-- list of 5 movies starting for 4th based on movies_id

SELECT *
FROM movies
ORDER BY 
	movie_id
LIMIT 5
OFFSET 3
;

SELECT *
FROM movies_revenues
ORDER BY 
	revenues_domestic DESC NULLS LAST
LIMIT 5
OFFSET 5
;


-- Using FETCH

-- 5 youngest american directors
SELECT *
FROM directors
WHERE 
	nationality = 'American'
ORDER BY
	date_of_birth DESC
FETCH FIRST 5 ROWS ONLY
;


-- 10 YOUNGEST FEMALE ACTRESS
SELECT * FROM actors;

SELECT *
FROM actors
WHERE 
	gender = 'F'
ORDER BY 
	date_of_birth DESC
FETCH FIRST 10 ROWS ONLY
;

-- 10 YOUNGEST FEMALE ACTRESS
SELECT * FROM actors;

SELECT *
FROM actors
WHERE 
	gender = 'F'
ORDER BY 
	date_of_birth DESC
FETCH FIRST 10 ROWS ONLY
OFFSET 5
;


-- Using IN and NOT IN

SELECT * 
FROM movies 
WHERE 
	movie_lang IN ('English', 'Chinese', 'Japanese')
ORDER BY 
	movie_lang
;


SELECT *
FROM movies
WHERE 	
	age_certificate IN ('18', 'PG')
ORDER BY
	age_certificate
;

SELECT * 
FROM movies 
WHERE 
	movie_lang NOT IN ('English', 'Chinese', 'Japanese')
ORDER BY 
	movie_lang
;


-- get all actors who actor_id is not 1,2,3,4

SELECT *
FROM actors
WHERE 
	actor_id NOT IN (1, 2, 3, 4) -- ('1', '2', '3', '4') this both is same for intergers
ORDER BY 
	actor_id
;

-- Using BETWEEN and NOT BETWEEN

-- actors birth date between 1991 and 1995

SELECT *
FROM actors
WHERE 
	date_of_birth BETWEEN '1991-01-01' AND '1995-12-31'
ORDER BY
	date_of_birth
;


-- movies released between 1998 - 2002

SELECT *
FROM movies
WHERE 
	release_date BETWEEN '1998-01-01' AND '2002-12-31'
ORDER BY
	release_date
;


-- movies domestic reveues between 100 - 300

SELECT *
FROM movies_revenues
WHERE 
	revenues_domestic BETWEEN 100.00 AND 300.00
ORDER BY
	revenues_domestic
;

-- movies length not in between 95 - 110 

SELECT *
FROM movies 
WHERE 
	movie_length NOT BETWEEN 95 AND 110
ORDER BY
	movie_length
;


-- Using LIKE and ILIKE

SELECT *
FROM actors
WHERE 
	first_name LIKE 'A%'
ORDER BY
	first_name
;

-- First name of only five characters

SELECT *
FROM actors
WHERE 
	first_name LIKE '_____'
ORDER BY
	first_name
;


-- actors whos first name's second character is l

SELECT *
FROM actors
WHERE
	first_name LIKE '_l%'
ORDER BY
	first_name
;


SELECT *
FROM actors
WHERE 
	first_name LIKE 'TIM' -- LIKE is case sensitive
;

SELECT *
FROM actors
WHERE 
	first_name ILIKE 'TIM' -- ILIKE is case in-sensitive
;


-- Using IS NULL and IS NOT NULL keywords


SELECT *
FROM actors
WHERE
	date_of_birth IS NULL
;


SELECT *
FROM actors
WHERE
	date_of_birth IS NULL
	OR first_name IS NULL
;


SELECT *
FROM movies_revenues
WHERE 
	revenues_domestic IS NULL
;


SELECT *
FROM movies
WHERE 	
	movie_id IN (
		SELECT movie_id
		FROM movies_revenues
		WHERE 
			revenues_domestic IS NULL
	);


SELECT *
FROM movies_revenues
WHERE 
	revenues_domestic IS NULL
	OR revenues_international IS NULL
;


SELECT *
FROM movies_revenues
WHERE
	revenues_domestic IS NOT NULL
;


SELECT *
FROM movies_revenues
WHERE 
	revenues_domestic IS NOT NULL
	AND revenues_international IS NULL
;



-- Concatenation techniques
-- Concatenation with ||, CONCAT and CONCAT_WS

-- concate first name and last name as actor name

SELECT 
	first_name || ' ' || last_name AS "Actor Name"
FROM actors
ORDER BY
	"Actor Name"
;

SELECT 
	CONCAT(first_name, ' ', last_name) AS "Actor Name"
FROM actors
ORDER BY 
	"Actor Name"
;

SELECT 
	CONCAT_WS(' ', first_name, last_name) AS "Actor Name"
FROM actors
ORDER BY
	first_name
;


SELECT *
FROM actors
WHERE 
	first_name IS NULL 
	OR last_name IS NULL
;

--- first name, last name, and date of birth seperated by ','

SELECT 
	CONCAT_WS(', ',first_name, last_name, date_of_birth) AS "Data String"
FROM actors
ORDER BY 
	first_name
;

-- Behaviour of ||, CONCAT and CONCAT_WS with NULL values
-- || if any of the value is NULL then entire value is NULL
-- CONCAT() no effect whether NULL or not
-- CONCAT_WS() delimiter is not printed for NULL values


SELECT 
	revenues_domestic,
	revenues_international,
	revenues_domestic || ' ' || revenues_international AS "Profits"
FROM movies_revenues

SELECT 
	revenues_domestic,
	revenues_international,
	CONCAT(revenues_domestic,' | ', revenues_international) AS "Profits"
FROM movies_revenues

SELECT 
	revenues_domestic,
	revenues_international,
	CONCAT_WS(' | ', revenues_domestic, revenues_international) AS "Profits"
FROM movies_revenues




SELECT *
FROM movies 
WHERE 
	movie_id IN 
	(SELECT movie_id
	FROM movies_actors 
	WHERE 
		actor_id = 33)
;







