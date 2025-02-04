-- 3 Modifying Data in the Tables

CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(150),
	age INT
);

SELECT * FROM customers;


-- Inserting a data into the table

INSERT INTO customers (first_name, last_name, email, age)
VALUES ('Pratik', 'Talaviya', 'pt@gmail.com', 22);


-- Inserting multiple records into the table

INSERT INTO customers (first_name, last_name, email, age)
VALUES
('Aditya', 'Sikarvar', 'as@gamil.com', 22),
('Deep', 'Dabhi', 'dd@gmail.com', 20),
('Karan', 'Joshi', 'kj@gmail.com', 21);


INSERT INTO customers (first_name, last_name, email, age)
VALUES ('Bill'O, 'John', 'bj@gmail.com', 35);


-- Insert a data that had quotes

INSERT INTO customers (first_name, last_name, email, age)
VALUES ('Bill''O', 'John', 'bj@gmail.com', 35);


-- Use RETURNING to get info on added rows

INSERT INTO customers (first_name)
VALUES ('Pratik') RETURNING * ;

INSERT INTO customers (first_name)
VALUES ('PJT') RETURNING customer_id;


-- Update data in a table

UPDATE customers 
SET email = 'pjt@gmail.com'
WHERE customer_id = 7;

UPDATE customers
SET 
first_name = 'PJ',
last_name = 'Talaviya',
age = 22
WHERE customer_id = 7;


-- Updating a row and returning the updated row

UPDATE customers 
SET 
email = 'pratik@gmail.com'
WHERE customer_id = 6
RETURNING *;


-- Updating all records in a table

UPDATE customers 
SET is_enable = 'Y';


-- Delete data from a table

DELETE FROM customers 
WHERE customer_id = 5;


SELECT * FROM customers;


-- Using UPSERT

CREATE TABLE t_tags(
	id SERIAL PRIMARY KEY,
	tag text UNIQUE,
	update_date TIMESTAMP DEFAULT NOW()
);

INSERT INTO t_tags (tag) values
('Pen'),
('Pencil');


SELECT * FROM t_tags;


INSERT INTO t_tags (tag) 
VALUES ('Pen')
ON CONFLICT (tag) 
DO 
	NOTHING;


SELECT * FROM t_tags;


INSERT INTO t_tags (tag) 
VALUES ('Pen1')
ON CONFLICT (tag) 
DO 
	UPDATE SET
		-- tag = EXCLUDED.tag || '1',
		update_date = NOW();
