-- Aggregate Functions

-- Counting results via COUNT function

SELECT COUNT(*) FROM movies;

SELECT COUNT(revenues_domestic) FROM movies_revenues;

SELECT COUNT(*) FROM movies_revenues;

SELECT 
	COUNT(DISTINCT(movie_lang))
FROM 
	movies;

SELECT COUNT(movie_lang) FROM movies;


-- counting movies with movie_lang as English

SELECT
	COUNT(*)
FROM
	movies
WHERE 
	movie_lang = 'English'; 

SELECT
	COUNT(*),
	COUNT(revenues_domestic),
	COUNT(revenues_international)
FROM movies_revenues;

SELECT *
FROM movies_revenues
WHERE 
	revenues_international IS NULL 
	AND revenues_domestic IS NULL;


-- SUM with SUM function

SELECT 
	SUM(revenues_domestic),
	SUM(revenues_international)
FROM 
	movies_revenues;


-- MIN and MAX functions

SELECT 
	MAX(movie_length),
	MIN(movie_length)
FROM 
	movies;


SELECT 
	MIN(release_date),
	MAX(release_date)
FROM movies
WHERE
	movie_lang = 'Japanese';


SELECT *
FROM movies
WHERE 
	movie_lang = 'Japanese'
ORDER BY
	release_date;

-- GREATEST and LEAST function

SELECT 
	movie_id,
	revenues_domestic,
	revenues_international,
	GREATEST(revenues_domestic, revenues_international) AS greatest,
	LEAST(revenues_domestic, revenues_international) AS least
FROM movies_revenues;


-- AVG function

SELECT 
	AVG(movie_length) as average
FROM 
	movies;

SELECT
	AVG(movie_length) as "Average English"
FROM movies
WHERE movie_lang = 'English';


-- Combining Columns using Mathematical operators

SELECT 
	revenues_domestic,
	revenues_international,
	(revenues_domestic + revenues_international) AS "Sum",
	(revenues_domestic - revenues_international) AS "Differnce"
FROM movies_revenues
ORDER BY 3 DESC NULLS LAST;