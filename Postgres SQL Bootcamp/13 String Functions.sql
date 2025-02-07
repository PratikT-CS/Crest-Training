-- String functions

-- UPPER, LOWER and INITCAP 

SELECT 
	UPPER(first_name) AS "First Name",
	UPPER(last_name) AS "Last Name"
FROM directors;

SELECT 
	INITCAP(
		CONCAT_WS(' ', first_name, last_name)
	) AS "Full Name"
FROM directors
ORDER BY 
	first_name;



-- LEFT and RIGHT

SELECT 
	first_name,
	LEFT(first_name, 5), -- first 5 char
	LEFT(first_name, -1), -- minus idicates leave -n number of char from end
	RIGHT(first_name, 5), -- last 5 char
	RIGHT(first_name, -2) -- here it is reveres will leave n from front
FROM directors;


SELECT 
	LEFT(first_name, 1) as "Initial"
FROM directors;

-- REVERSE

SELECT REVERSE('PRATIK');

SELECT REVERSE('KITARP');


-- SPLIT_PART

SELECT SPLIT_PART('1,2,3', ',', 1); -- OUTPUT 1
SELECT SPLIT_PART('1,2,3', ',', 2); -- OUTPUT 2
SELECT SPLIT_PART('1,2,3', ',', 3); -- OUTPUT 3


SELECT SPLIT_PART('A|B|C|D', '|', 3) -- OUTPUT C

SELECT
	movie_name,
	release_date,
	SPLIT_PART(release_date::TEXT, '-', 1) AS "Year" 
	-- HERE WE NEED TO CONVERT DATE DATA TYPE TO STRING BECAUSE SPLIT_PART ONLY WORKS WITH STRING/TEXT
FROM 	
	movies
ORDER BY
	"Year"
;


SELECT *
FROM movies;

-- LPAD and RPAD

SELECT 
	movie_id,
	LPAD(movie_id::TEXT, 4, 'A') AS "Alphnumeric Id",
	movie_name
FROM
	movies


SELECT 
	movie_id,
	RPAD(movie_id::TEXT, 4, 'A') AS "Alphnumeric Id",
	movie_name
FROM
	movies


-- LENGTH

SELECT
	first_name,
	LENGTH(first_name) AS length_first_name -- WE CAN ALSO USE CHAR_LENGTH(COLUMN_NAME)
FROM 
	directors
ORDER BY 2 DESC;



