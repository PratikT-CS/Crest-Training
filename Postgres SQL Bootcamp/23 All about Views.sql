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


-- create view of data from tables movies, directors and movie_revenues

CREATE VIEW v_movies_directors_revenues AS
SELECT *
FROM directors
INNER JOIN 
	movies 
		USING(director_id)
INNER JOIN 
	movies_revenues
		USING(movie_id)
;


SELECT *
FROM 
	v_movies_directors_revenues
WHERE 	
	age_certificate = '12'
;

ALTER VIEW v_directors_full_name 
RENAME TO v_directors
;


-- REARRANGING AND DELETING COLUMN IN NOT ALLOWED IN POSTGRES
-- SO TO ACHIVE THAT WE CREATE NEW VIEW THE REQUIRED COLUMNS AND ARRANGEMENT



-- WITH REPLACE CLAUSE WITH CREATE WE CAN ADD NEW COLUMN TO VIEW BUT WE CAN'T REARRANGE THEM 



-- REGULAR VIEWS ARE DYNAMIC UPDATE IN TABLE IS REFELCTED IN VIEW ITSELF WITHOUT CHANGING THEM



-- IF VIEW DOESN'T CONTAINT ANY AGGREGATE FUCTION, ANY OTHER COMPLEX CLAUSE SUCH AS DISTINCT, LIMIT
-- GROUP BY, ETC THEM THE VIEW IS UPADATED ABLE
-- WHICH MEANS THAT WE CAN PERFORM INSERT, UPDATE AND DELETE OPERATIONS ON VIEW
-- WHICH WILL GET REFLECTED IN TABLE ITSELF


CREATE OR REPLACE VIEW 
	vu_directors AS
SELECT 
	first_name,
	last_name
FROM 
	directors
;

INSERT INTO vu_directors (first_name)
VALUES ('test_dir');

SELECT *
FROM vu_directors;

SELECT *
FROM directors;

DELETE FROM 
 	vu_directors 
WHERE 
	first_name = 'test_dir'
;

SELECT * 
FROM vu_directors;



-- WITH CHECK OPTIONS

CREATE TABLE countries (
	country_id SERIAL PRIMARY KEY,
	country_code VARCHAR(4),
	city_name VARCHAR(100)
);

INSERT INTO countries (country_code, city_name)
VALUES
('US','New York'),
('US','New Jersey'),
('UK','London');

SELECT * FROM countries;


CREATE OR REPLACE VIEW view_cities_us AS
SELECT 
	country_id, 
	country_code, 
	city_name
FROM 
	countries
WHERE 
	country_code = 'US';

SELECT * 
FROM view_cities_us;


INSERT INTO view_cities_us (country_code, city_name)
VALUES ('US','California');

SELECT * 
FROM view_cities_us;

INSERT INTO view_cities_us (country_code, city_name)
VALUES ('UK','Manchester');

-- problem here is that we can add data of uk as well though our view just shows data from us only
-- to over come that we use with check option which is forces to check conditions while inserting as well

SELECT * 
FROM view_cities_us;

SELECT * 
FROM countries;


CREATE OR REPLACE VIEW 
	view_cities_us AS
SELECT 
	country_id, 
	country_code, 
	city_name
FROM 
	countries
WHERE 
	country_code = 'US'
WITH CHECK OPTION;


INSERT INTO view_cities_us (country_code, city_name)
VALUES
('UK','Leeds'); -- this will give error because we have used with check option in our view while creating it

SELECT * 
FROM view_cities_us;

SELECT * 
FROM countries;

UPDATE 
	view_cities_us
SET 
	country_code = 'UK'
WHERE 
	city_name = 'New York'; -- this will give error now because we have used with check option in our view


INSERT INTO view_cities_us (country_code, city_name)
VALUES ('US','Chicago');

SELECT *
FROM view_cities_us;


-- we can also nest the views within the view

-- LOCAL and CASCADED CHECK OPTION

CREATE OR REPLACE VIEW 
	view_cities_c AS
SELECT 
	country_id, 
	country_code, 
	city_name
FROM 
	countries
WHERE 
	city_name LIKE 'C%';

SELECT * 
FROM view_cities_c;


CREATE OR REPLACE VIEW 
	view_cities_us_c AS
SELECT 
	country_id, 
	country_code, 
	city_name
FROM 
	view_cities_c
WHERE 
	country_code = 'US'
WITH LOCAL CHECK OPTION; -- here we have nested a view inside another view

-- HERE LOCAL WILL JUST FORCE TO CHECK CURRENT VIEW CONDITIONS NOT FOR THE PREVIOUS ONE

INSERT INTO view_cities_us_c (country_code, city_name)
VALUES
('US','Connecticut');

SELECT * FROM view_cities_us_c;

INSERT INTO view_cities_us_c (country_code, city_name)
VALUES
('US','Los Angeles'); -- HERE BECAUSE OF LOCAL WE ARE ABLE TO ADD THE DATA TO THE VIEW

SELECT * FROM view_cities_us_c;

SELECT * FROM countries;

-- CASCADED

CREATE OR REPLACE VIEW 
	view_cities_us_c AS
SELECT 
	country_id, 
	country_code, 
	city_name
FROM 
	view_cities_c
WHERE 
	country_code = 'US'
WITH CASCADED CHECK OPTION;


INSERT INTO view_cities_us_c (country_code, city_name)
VALUES ('US','Boston'); 
-- NOW THIS WILL GIVE ERROR BECAUSE WE HAVE USED CASCADED 
-- WHICH FORCE TO CHECK CONDITION OF PREVIOUS VIEW AS WELL

INSERT INTO view_cities_us_c (country_code, city_name)
VALUES ('US','Clear Water');

SELECT * 
FROM view_cities_us_c;



-- MATERIALIZED VIEW

-- WITH DATA

CREATE MATERIALIZED VIEW IF NOT EXISTS 
	mv_directors AS
SELECT 
	first_name,
	last_name
FROM 
	directors
WITH DATA
;

SELECT *
FROM mv_directors;


-- WITHOUT DATA (NO DATA)

CREATE MATERIALIZED VIEW IF NOT EXISTS
	mv_directors_nodata AS
SELECT 
	first_name,
	last_name
FROM 
	directors
WITH NO DATA
;

SELECT *
FROM mv_directors_nodata;

REFRESH MATERIALIZED VIEW mv_directors_nodata;


-- drop a materialized view

DROP MATERIALIZED VIEW mv_directors_nodata;


-- in materialized view we can't perform any insert, delete or update operation as we could in normal view
-- we have to update the underlying table then we have to refresh the materialized we to view the changes

INSERT INTO mv_directors (first_name) 
VALUES ('test_dir'); -- will give error



--  how to check is materialized view is populated or not

SELECT *
FROM pg_class;


SELECT *
FROM 
	pg_class
WHERE 
	relname = 'mv_directors'
;


SELECT 
	relispopulated
FROM 
	pg_class
WHERE 
	relname = 'mv_directors'
;


-- WE CAN'T ACCESS TABLE WHEN IT'S MATERIALIZED VIEW IS REFRESHING 
-- POSTGRES LOCKS THE TABLE
-- TO USE TABLE WHILE IT MATERILIZED VIEW IS REFRESHING WE HAVE TO USE CONCURRETLY IN REFRESH QUERY
-- TO USE CONCURRENTLY THERE MUST BE ONE UNIQUE INDEX FOR THAT TABLE
-- SO FIRST CREATE UNIQUE INDEX WITHOUT WHERE CLAUSE AND THEN USE CONCURRENTLY

CREATE MATERIALIZED VIEW 
	mv_directors_us AS
SELECT 
	director_id, 
	first_name, 
	last_name, 
	date_of_birth,
	nationality
FROM 
	directors
WHERE 
	nationality = 'American'
WITH NO DATA;

SELECT * FROM mv_directors_us;


REFRESH MATERIALIZED VIEW mv_directors_us;

SELECT * 
FROM mv_directors_us;


CREATE UNIQUE INDEX 
	idx_u_mv_directors_us_director_id 
	ON mv_directors_us (director_id);

REFRESH MATERIALIZED VIEW CONCURRENTLY mv_directors_us;

SELECT * 
FROM mv_directors_us;

-- list all materialized view

SELECT *
FROM 
	pg_class
WHERE
	relkind = 'm'
;






