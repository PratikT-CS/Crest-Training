-- JSON with PostgreSQL

-- json data type

SELECT 
	'{
		"title" : "Bhagam Bhag"	
	 }'::JSON
; -- JSON preserves white space

-- jsonb data type

SELECT 
	'{
		"title" : "Bhagam Bhag"	
	 }'::JSONB
; -- JSONB doesn't preserve whtie space it trims them off



CREATE TABLE books(
	book_id SERIAL PRIMARY KEY,
	book_info JSONB
);

INSERT INTO books (book_info) VALUES
('{
	"title" : "Book Title 1",
	"author" : "Author 1"
}'),
('{
	"title" : "Book Title 2",
	"author" : "Author 2"
}'),
('{
	"title" : "Book Title 3",
	"author" : "Author 3"
}'),
('{
	"title" : "Book Title 4",
	"author" : "Author 4"
}')
;

SELECT *
FROM books;

SELECT 
	book_info ->> 'title' AS title,
	book_info -> 'title' AS title_quotes
FROM
	books
;


UPDATE 
	books
SET
	book_info = book_info || '{"author" : "Pratik"}'
WHERE
	-- book_info -> 'title' = '"Book Title 1"' -- see difference in value for title with quotes and without
	book_info ->> 'title' = 'Book Title 1'
;

SELECT 
	book_info ->> 'title',
	book_info ->> 'author'
FROM 
	books
;

-- we can also add field in the json object in same way we update the fields

UPDATE 
	books
SET
	book_info = book_info || '{"price" : "1110"}' -- this will add new field
WHERE
	book_info ->> 'title' = 'Book Title 1'
;


-- deleting field in json

UPDATE 
	books
SET
	book_info = book_info - 'price'  -- just pass key to delete pair
WHERE
	book_info ->> 'title' = 'Book Title 1'
;



SELECT *
FROM books;




-- Rows to JSON object

SELECT * 
FROM directors;

SELECT
	ROW_TO_JSON(directors)
FROM
	directors
;

-- we can take specific columns as well

SELECT
	ROW_TO_JSON(t)
FROM(
	SELECT 
		first_name,
		last_name,
		nationality
	FROM	
		directors
	) AS t
;

-- json aggregate

SELECT 
	first_name,
	last_name,
	(
		SELECT JSON_AGG(x) as movies 
		FROM(
			SELECT 
				movie_name
			FROM 	
				movies
			WHERE 
				director_id = directors.director_id
		) AS x
	)
FROM 
	directors
;


SELECT 
	first_name,
	last_name,
	(
        SELECT COUNT(*) 
        FROM movies 
        WHERE director_id = directors.director_id
    ) AS movie_count,
	(
		SELECT JSON_AGG(x) as movies 
		FROM(
			SELECT 
				movie_name
			FROM 	
				movies
			WHERE 
				director_id = directors.director_id
		) AS x
	)
FROM 
	directors
;



CREATE TABLE director_docs(
	id SERIAL PRIMARY KEY,
	body JSONB
);


INSERT INTO director_docs (body)
SELECT ROW_TO_JSON(a) 
FROM (
	SELECT 
    *,
	(
        SELECT COUNT(*) 
        FROM movies 
        WHERE director_id = directors.director_id
    ) AS movie_count,
	(
		SELECT JSON_AGG(x) as movies 
		FROM(
			SELECT 
				movie_name
			FROM 	
				movies
			WHERE 
				director_id = directors.director_id
		) AS x
		)
	FROM 
		directors
) AS a;


SELECT 
	body ->> 'movie_count',
	*
FROM director_docs
WHERE
	(body ->> 'movie_count')::INT > 2
;


SELECT
	body->>'first_name',
	body->>'last_name',
	JSONB_ARRAY_LENGTH(body->'movies') AS movie_count
FROM 
	director_docs
ORDER BY
	movie_count DESC;
;


SELECT
	DISTINCT JSONB_OBJECT_KEYS(body)
FROM
	director_docs
;


SELECT
	j.key,
	j.value
FROM	
	director_docs,
	JSONB_EACH(director_docs.body) AS j
LIMIT 18
;


-- existance operator ?

SELECT *
FROM
	director_docs
WHERE 
	body->'first_name' ? 'John'
; 	


SELECT *
FROM	
	director_docs
WHERE 
	(body->>'movie_count')::TEXT = '2'
; 	


-- contacts_docs

SELECT *
FROM contacts_docs;


SELECT *
FROM contacts_docs
WHERE
	body @>'{"first_name" : "John"}'
;



EXPLAIN ANALYZE SELECT *
FROM contacts_docs
WHERE
	body @>'{"first_name" : "John"}'
;



SELECT 
	jsonb_array_elements(body->'movies') AS skill,
	body->>'director_id'
FROM 
	director_docs
;
