-- Modifying Table Structures, Add Constraints

CREATE TABLE persons(
	person_id SERIAL PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL
);

ALTER TABLE persons
ADD COLUMN age INT NOT NULL;

ALTER TABLE persons
ADD COLUMN nationality VARCHAR(20) NOT NULL,
ADD COLUMN email VARCHAR(100) UNIQUE;


SELECT *
FROM persons;


-- Modifying table structure 

-- Rename a table

ALTER TABLE persons
RENAME TO users;

ALTER TABLE users
RENAME TO persons;

-- Rename a column

ALTER TABLE persons
RENAME COLUMN age TO person_age;

SELECT *
FROM persons;

-- Drop a column
ALTER TABLE persons
DROP COLUMN person_age;

-- Readding the column

ALTER TABLE persons
ADD COLUMN person_age VARCHAR(10);


-- Changing type of column

ALTER TABLE persons
ALTER COLUMN person_age TYPE INT
USING person_age::integer; -- need to use this using because we are converting varchar to int

ALTER TABLE persons
ALTER COLUMN person_age TYPE VARCHAR(20); -- HERE NO NEED TO TYPE CAST  


ALTER TABLE persons
RENAME COLUMN person_age TO age;

ALTER TABLE persons
ADD COLUMN is_enable BOOLEAN;


-- Set default value for a column

ALTER TABLE persons
ALTER COLUMN is_enable
SET DEFAULT TRUE;

INSERT INTO persons
(
	first_name,
	last_name,
	nationality,
	age
)
VALUES
(
	'Pratik',
	'Talaviya',
	'Indian',
	22
)


SELECT *
FROM persons;

UPDATE persons
SET email = 'pratik@gmail.com'
WHERE person_id = 1;
	


-- Add constraints to column
CREATE TABLE web_links(
	link_id SERIAL PRIMARY KEY,
	link_url VARCHAR(255) NOT NULL,
	link_target VARCHAR(20)
);


INSERT INTO web_links (link_url, link_target)
VALUES ('https://www.amazon.com', '_blank');

-- adding unique constraint to link_url column

ALTER TABLE web_links
ADD CONSTRAINT unique_url UNIQUE (link_url);


SELECT *
FROM web_links;

ALTER TABLE web_links
ADD COLUMN is_enable VARCHAR(2);


INSERT INTO web_links (link_url, link_target, is_enable)
VALUES ('https://www.netflix.com', '_blank', 'Y');

ALTER TABLE web_links
ADD CHECK (is_enable IN ('Y', 'N'));

INSERT INTO web_links (link_url, link_target, is_enable)
VALUES ('https://www.primevideo.com', '_blank', 'P');

INSERT INTO web_links (link_url, link_target, is_enable)
VALUES ('https://www.primevideo.com', '_blank', 'Y');


UPDATE web_links
SET is_enable = 'Y'
WHERE link_id IN (1, 3);

SELECT *
FROM web_links
ORDER BY 
	link_id;

UPDATE web_links
SET is_enable = 'N'
WHERE link_id = 3;















