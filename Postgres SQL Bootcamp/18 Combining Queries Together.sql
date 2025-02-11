-- Combining queries together

-- Combining result set with union

SELECT 
	product_id,
	product_name
FROM 
	left_products
UNION
SELECT
	product_id,
	product_name
FROM
	right_products
ORDER BY
	product_id
;


INSERT INTO left_products (product_id, product_name) VALUES (7, 'Pens');

-- UNION WILL RETURN DUPLICATE VALUE ONLY ONCES IF YOU WANT ALL THE DUPLICATE THEN USE UNION ALL

SELECT 
	product_id,
	product_name
FROM 	
	left_products
UNION ALL
SELECT
	product_id,
	product_name
FROM
	right_products
ORDER BY
	product_id
;


-- Combine directors and actors table

SELECT 
	first_name,
	last_name
FROM 
	directors -- 37 records in directors
UNION
SELECT
	first_name,
	last_name
FROM 
	actors -- 147 records in actors
ORDER BY
	first_name -- total 182 records
;


SELECT 
	first_name,
	last_name,
	'director' AS post
FROM 
	directors -- 37 records in directors
UNION
SELECT
	first_name,
	last_name,
	'actor' AS post 
FROM 
	actors -- 147 records in actors
ORDER BY
	first_name -- total 182 records
;

-- we can use the different columns with same data type with union. 
-- but if the data type is different then it will give error

SELECT 
	first_name,
	last_name
FROM 
	directors
WHERE 
	nationality IN ('American', 'Chinese', 'Japanese')
UNION
SELECT
	first_name,
	last_name
FROM 
	actors
WHERE
 	gender = 'F'
;


-- actors born after 1990 and directors born after 1960

SELECT 
	first_name,
	last_name,
	date_of_birth,
	'directors' AS tablename
FROM	
	directors
WHERE 
	date_of_birth > '1960-12-31' 
UNION
SELECT
	first_name,
	last_name,
	date_of_birth,
	'actors' AS tablename
FROM 
	actors
WHERE 
	date_of_birth > '1990-12-31'
ORDER BY 
 	date_of_birth
;


-- first name starting with A

SELECT 
	first_name,
	last_name
FROM 
	directors
WHERE 
	first_name LIKE 'A%'
UNION
SELECT
	first_name,
	last_name
FROM 
	actors
WHERE
 	first_name LIKE 'A%'
;


-- INTERSECT
-- returns only common values between the tables

SELECT 
	 product_id,
	 product_name
FROM 
	left_products
INTERSECT
SELECT
	product_id,
	product_name
FROM 
	right_products
;

-- intersect directors and actors

SELECT 
	first_name,
	last_name
FROM 
	directors
INTERSECT
SELECT
	first_name,
	last_name
FROM
	actors
;


-- EXCEPT
-- used to get the result which is not matching between the tables just from first table only

SELECT
	product_name,
	product_id
FROM
	left_products
EXCEPT
SELECT
	product_name,
	product_id
FROM
	right_products
;


SELECT
	product_name,
	product_id
FROM
	right_products
EXCEPT
SELECT
	product_name,
	product_id
FROM
	left_products
;