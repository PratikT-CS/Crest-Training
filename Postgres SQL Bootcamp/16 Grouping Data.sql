-- Grouping Data

-- total count of movies group by movie language

SELECT 
	movie_lang,
	COUNT(movie_id)
FROM 	
	movies
GROUP BY
 	movie_lang
ORDER BY
	2 DESC;


-- get average movie length group by movie language

SELECT 
	movie_lang,
	AVG(movie_length)
FROM 
	movies
GROUP BY
	movie_lang
ORDER BY
	2 DESC
;

-- min and max movie length group by movie language

SELECT
	movie_lang,
	MAX(movie_length),
	MIN(movie_length)
FROM 	
	movies
GROUP BY
	movie_lang
;

-- we can use group without aggregate functions it will remove duplicates and will function as distinct

SELECT
	movie_lang
FROM
	movies
GROUP BY
	movie_lang
; -- this query will only output distinct languages here only 8 records


SELECT
	movie_lang
FROM movies
; -- this query will output the movie language column with all the records here 53


SELECT 
	DISTINCT movie_lang
FROM movies
; -- this query will return only unique languages in the table same as first one

-- we can't use column1 without specifying them in group clause or aggregate funciton

SELECT 
	movie_lang,
	SUM(movie_length)
FROM 
	movies
GROUP BY
	movie_lang -- if we don't use group here then this will give error
;

SELECT
	movie_length,
	SUM(movie_length)
FROM 	
	movies; -- THIS WILL GIVE ERROR AND WILL TELL TO USE GROUP BY CLAUSE..

-- get average movie length group by movie length and age certificate

SELECT 
	movie_lang,
	age_certificate,
	COUNT(*) AS total_movies,
	AVG(movie_length) AS average_length,
	SUM(movie_length) AS total_length
FROM 
	movies
GROUP BY
	movie_lang,
	age_certificate
ORDER BY 
	movie_lang,
	total_length
;


-- using where clause 
-- we need to use where clause before group by clause

SELECT 
	movie_lang,
	age_certificate,
	AVG(movie_length)
FROM
	movies
WHERE 
	movie_length > 100
GROUP BY
	movie_lang,
	age_certificate
;


-- get average movie length group by movie_lang and age_certificate where age_certificate = 12

SELECT 
	movie_lang,
	age_certificate,
	AVG(movie_length),
	COUNT(movie_id)
FROM 
	movies
WHERE 
	age_certificate = '12'
GROUP BY
	movie_lang,
	age_certificate
ORDER BY 
	movie_lang
;


-- directors from each nationality

SELECT
	nationality,
	COUNT(director_id) -- Here we can use COUNT(*) also
FROM 
	directors
GROUP BY 
	nationality
ORDER BY 
	2 DESC
;


-- sum of movie length group by movie language and is having sum greater than 100

SELECT
	movie_lang,
	SUM(movie_length) 
FROM 
	movies
GROUP BY
	movie_lang
HAVING
	SUM(movie_length) > 100
ORDER BY
	2 DESC
;


-- list director where there total movie length is greater than 200


SELECT 
	director_id,
	SUM(movie_length),
	COUNT(*)  
FROM 
	movies
GROUP BY
	director_id
HAVING
	SUM(movie_length) > 200
ORDER BY 
	2 DESC
;


-- WE CAN USE COALESCE(column_name, 'something suitable') 
-- suppose we have department column with some null values
-- then COALESCE(departmen, 'no department') hee null will be replaced with no department
-- this done for better readability of output data.
	