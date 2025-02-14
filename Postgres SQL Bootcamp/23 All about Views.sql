-- All about Views

-- creating view with directors first_name, last_name 

CREATE OR REPLACE VIEW 
	v_directors_name AS
	SELECT 
		first_name,
		last_name
	FROM 
		directors
;

SELECT * 
FROM v_directors_name; 


-- RENAME A VIEW

ALTER VIEW v_directors_name
RENAME TO v_directors_full_name
;


-- Drop a view

CREATE VIEW test_view AS 
	SELECT 
		movie_name,
		movie_lang,
		movie_length
	FROM 
		movies
;

SELECT * 
FROM test_view;

DROP VIEW test_view;


-- filter data/rows from view

SELECT *
FROM v_directors_full_name
WHERE 
	first_name LIKE 'J%'
;


-- create a view of movies released after 1997

CREATE OR REPLACE VIEW v_movies_after_1997 AS
	SELECT *
	FROM 
		movies
	WHERE 
		release_date > '1997-12-31'
	ORDER BY 
		release_date
;

SELECT *
FROM 
	v_movies_after_1997
;

-- NOW FILTER ONLY ENGLISH MOVIES FROM THE VIEW CREATED

SELECT *
FROM 
	v_movies_after_1997
WHERE 
	movie_lang = 'English'
;

SELECT 
	DISTINCT movie_lang
FROM 
	v_movies_after_1997
;


-- using union and creating multiple tables


CREATE OR REPLACE VIEW v_all_actors_directors AS
	SELECT 
		first_name,
		last_name,
		'Actor' AS tablename
	FROM 
		actors
	UNION ALL
	SELECT
		first_name,
		last_name,
		'Director' AS tablename
	FROM 
		directors
;


SELECT *
FROM v_all_actors_directors;






