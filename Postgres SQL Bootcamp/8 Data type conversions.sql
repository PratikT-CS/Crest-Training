-- Data type conversions

SELECT *
FROM movies
WHERE movie_id = 1;

SELECT * 
FROM movies
WHERE movie_id = '1'; -- 	Implict type conversion

SELECT * 
FROM movies 
WHERE movie_id = integer '1'; -- Explict type conversion

-- type conversion using cast function

SELECT 
	CAST('10' AS INTEGER);

SELECT 
	CAST('2025-02-05' AS DATE),
	CAST('05-FEB-2025' AS DATE);

-- :: CAN ALSO BE USED FOR TYPE CONVERSION

SELECT 
	'05-FEB-2025'::DATE,
	'03-NOV-2025'::DATE;

SELECT 
	'15 MINUTES'::INTERVAL,
	'3 weeks'::INTERVAL,
	'9 hours'::INTERVAL,
	'3 DAYS'::INTERVAL;

SELECT 
	'2025-02-05 14:08:19.956'::TIMESTAMP,
	'2025-02-05 14:09:20.234'::TIMESTAMPTZ;


SELECT FACTORIAL(5);

SELECT SUBSTR('Pratik',4);

SELECT SUBSTR('123456', 3);

SELECT CAST(SUBSTR('123456', 3) AS INTEGER);


CREATE TABLE ratings(
	rating_id SERIAL PRIMARY KEY,
	rating VARCHAR(1) NOT NULL
);


INSERT INTO ratings (rating) VALUES
('A'),
('B'),
('C'),
('D');


INSERT INTO ratings (rating) VALUES
('1'),
('2'),
('3'),
('4');

SELECT *
FROM ratings;


SELECT 
	rating_id,
	CASE
		WHEN rating~E'^\\d+$' THEN
			CAST (rating AS INTEGER)
		ELSE
			0
		END AS rating
FROM 
	ratings;















