-- Conversion Functions

-- to_char

SELECT 
	release_date,
	TO_CHAR(release_date, 'DD-MM-YYYY'),
	TO_CHAR(release_date, 'DD Mon YY'),
	TO_CHAR(release_date, 'DD Dy Mon YYYY'),
	TO_CHAR(release_date, 'Dy DD MM-YYYY')
FROM movies;

SELECT
	TO_CHAR(
		NOW(),
		'HH24:MI:SS'
	);


SELECT 
	movie_id,
	revenues_domestic,
	revenues_international,
	TO_CHAR(revenues_domestic, '$99999D99'),
	TO_CHAR(revenues_international, '$99999D99')
FROM movies_revenues
ORDER BY revenues_domestic;


-- to_number

SELECT 
	TO_NUMBER(
		'10,625.75-',
		'99G999D99S'
	);

SELECT
	TO_NUMBER(
		'$1,499.64',
		'L9G999'
	);


SELECT 
	TO_NUMBER(
		'1,254,235.45',
		'9g999g999d99'
	); 


-- to_date


SELECT 
	TO_DATE(
		'04 Thu Jan 2001',
		'DD Dy Mon YYYY'
	)
;

SELECT 
	TO_DATE(
		'Wed 15 08-1979',
		'Dy DD MM-YYYY'
	)
;


SELECT 
	TO_DATE(
		'15/08-1979',
		'DD/MM-YYYY'
	)
;

-- to_timestamp


SELECT 
	TO_TIMESTAMP(
		'2002-11-03 06-15-00',
		'YYYY-MM-DD HH24-MI-SS'
	)
;
SELECT 
	TO_TIMESTAMP(
		'2002-11-03 06-15-00',
		'YYYY-MM-DD HH24-MI-SS'
	)
;


SELECT 
	TO_TIMESTAMP(
		'2002/11/03 06/15/00',
		'YYYY/MM/DD HH24/MI/SS'
	)
;
























