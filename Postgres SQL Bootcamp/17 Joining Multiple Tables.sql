-- Joining Multiple Tables

-- INNER JOIN
-- Combining movies and directors table

SELECT 
	movies.movie_lang,
	directors.first_name,
	directors.last_name,
	directors.nationality,
	movies.movie_name
FROM 
	directors
INNER JOIN 
 	movies ON
		directors.director_id = movies.director_id
ORDER BY
	movie_lang
;


SELECT 
	movies.movie_lang,
	movies.movie_name,
	directors.nationality,
	directors.first_name,
	directors.last_name
FROM 
	directors
INNER JOIN 
	movies ON
		directors.director_id = movies.director_id
ORDER BY
	movie_lang,
	nationality
;


-- we can use USING if we have same column name in both the tables otherwise use ON

SELECT 
	movies.movie_lang,
	movies.movie_name,
	directors.nationality,
	directors.first_name,
	directors.last_name
FROM 
	directors
INNER JOIN 
	movies USING(director_id)
;


-- Combining movies and movies_revenues tables

SELECT *
FROM 	
	movies 
INNER JOIN
	movies_revenues USING(movie_id)
;


-- We can combine more than two tables as well
-- combining movies, directors and movies_revenues

SELECT 
	mv.movie_name,
	d.first_name,
	d.last_name,
	r.revenues_domestic,
	r.revenues_international
FROM 
movies AS mv
INNER JOIN 
	directors AS d 
		USING(director_id)
INNER JOIN
	movies_revenues AS r 
		USING(movie_id)
;


-- filtering data with join

-- selecting movie name, director name, domestic revenues for all the japanese movies

SELECT
	mv.movie_name,
	d.first_name || ' ' || d.last_name,
	r.revenues_domestic
FROM 
	movies AS mv
INNER JOIN
	directors AS d	
		USING(director_id)
INNER JOIN 
	movies_revenues AS r
		USING(movie_id)
ORDER BY
	r.revenues_domestic DESC NULLS LAST
;


SELECT
	mv.movie_name,
	d.first_name || ' ' || d.last_name,
	r.revenues_domestic
FROM 
	movies AS mv
INNER JOIN
	directors AS d	
		USING(director_id)
INNER JOIN 
	movies_revenues AS r
		USING(movie_id)
WHERE mv.movie_lang = 'Japanese'
ORDER BY
	r.revenues_domestic DESC NULLS LAST
;


-- select movie name, director name for all english, chinese and japanese movies where domestic revenue >200

SELECT
	mv.movie_name,
	d.first_name || ' ' || d.last_name AS director_name,
	r.revenues_domestic
FROM 
	movies AS mv
INNER JOIN
	directors AS d 
		USING(director_id)
INNER JOIN
	movies_revenues AS r
		USING(movie_id)
WHERE 
	r.revenues_domestic > 200 
	AND mv.movie_lang IN ('English', 'Chinese', 'Japanese')
ORDER BY
	3 DESC
;



SELECT
	mv.movie_name,
	d.first_name || ' ' || d.last_name AS director_name,
	(r.revenues_domestic + r.revenues_international) AS total_revenue
FROM 
	movies AS mv
INNER JOIN
	directors AS d 
		USING(director_id)
INNER JOIN
	movies_revenues AS r
		USING(movie_id)
ORDER BY
	total_revenue DESC NULLS LAST
LIMIT 5
;


-- top 10 profitable movies between 2005 to 2008


SELECT
	mv.movie_name,
	mv.movie_lang,
	d.first_name || ' ' || d.last_name AS director_name,
	(r.revenues_domestic + r.revenues_international) AS total_revenue
FROM 
	movies AS mv
INNER JOIN
	directors AS d 
		USING(director_id)
INNER JOIN
	movies_revenues AS r
		USING(movie_id)
WHERE 
	release_date BETWEEN '2005-01-01' AND '2008-12-31'
ORDER BY
	total_revenue DESC NULLS LAST
LIMIT 10
;



-- LEFT JOIN

CREATE TABLE left_products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100)
);

CREATE TABLE right_products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100)
);


INSERT INTO left_products (product_id, product_name) VALUES
(1, 'Laptops'),
(2, 'Computers'),
(3, 'Mobile'),
(5, 'Printers')
;


INSERT INTO right_products (product_id, product_name) VALUES
(1, 'Laptops'),
(2, 'Computers'),
(3, 'Mobile'),
(4, 'Mics'),
(6, 'Pens')
;

SELECT * 
FROM left_products
LEFT JOIN 
	right_products USING(product_id)
;

-- Count all movies for each directors

SELECT
	d.director_id,
	d.first_name || ' ' || d.last_name,
	COUNT(*)
FROM directors AS d
LEFT JOIN
	movies AS mv 
		USING(director_id)
GROUP BY 
	director_id
ORDER BY
	3 DESC
;


-- get all the movies for all directors where nationality 'American', 'Chinese' and 'Japanese'

SELECT
	d.nationality,
	d.first_name || ' ' || d.last_name AS full_name,
	mv.movie_name,
	mv.age_certificate
FROM directors AS d
LEFT JOIN 
	movies AS mv
		USING(director_id)
WHERE 
	d.nationality IN ('American', 'Chinese', 'Japanese')
ORDER BY
	nationality,
	full_name
;


-- get total revenue of each film of each director

SELECT
	d.first_name || ' ' || d.last_name AS full_name,
	(r.revenues_domestic + r.revenues_international) AS total_revenue
FROM
	directors AS d
LEFT JOIN 
	movies AS m
		USING(director_id)
LEFT JOIN 
	movies_revenues AS r
		USING(movie_id)
ORDER BY
	total_revenue DESC NULLS LAST
;

SELECT
	d.director_id,
	d.first_name || ' ' || d.last_name AS full_name,
	SUM(r.revenues_domestic + r.revenues_international) AS total_revenue
FROM
	directors AS d
LEFT JOIN 
	movies AS m
		USING(director_id)
LEFT JOIN 
	movies_revenues AS r
		USING(movie_id)
GROUP BY
	d.director_id
ORDER BY
	total_revenue DESC NULLS LAST
;



-- RIGHT JOIN

SELECT *
FROM left_products
RIGHT JOIN right_products
	USING(product_id)
;

SELECT *
FROM left_products
RIGHT JOIN right_products
	ON left_products.product_id = right_products.product_id
;


-- FULL JOIN

SELECT *
FROM left_products
FULL JOIN right_products
	USING(product_id)
;


-- Joining multiple tables 

-- Joining movies, actors, directors and movies_revenue table

SELECT 
	mv.movie_name,
	a.first_name || ' ' || a.last_name AS actor_name,
	d.first_name || ' ' || d.last_name AS director_name,
	a.gender,
	(r.revenues_domestic + r.revenues_international) AS total_revenue
FROM movies AS mv
JOIN movies_actors AS ma
	USING(movie_id)
JOIN actors AS a
	USING(actor_id)
JOIN directors AS d
	USING(director_id)
JOIN movies_revenues AS r
	USING(movie_id)
ORDER BY 
	total_revenue DESC NULLS LAST
;



-- SELF JOIN

SELECT 
	t1.movie_name,
	t2.movie_name,
	t1.movie_length
FROM 
	movies AS t1
INNER JOIN
	movies AS t2 ON t1.movie_length = t2.movie_length
	AND t1.movie_name <> t2.movie_name
ORDER BY 
	3 DESC
;

SELECT 
	t1.movie_name,
	t2.movie_name,
	t1.movie_length
FROM 
	movies AS t1
INNER JOIN
		movies AS t2 USING(movie_length)
WHERE
	t1.movie_name <> t2.movie_name AND
    t1.movie_name < t2.movie_name
ORDER BY 
	3 DESC
;

SELECT *
FROM 
	movies AS t1
INNER JOIN
		movies AS t2 USING(movie_length)
ORDER BY
	t1.movie_id,
	t2.movie_id
;

SELECT *
FROM left_products
CROSS JOIN right_products
;

SELECT *
FROM right_products
CROSS JOIN 	left_products
;



