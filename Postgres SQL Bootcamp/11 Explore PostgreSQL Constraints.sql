-- Explore PostgreSQL Constraints

-- NOT NULL Constraint

CREATE TABLE table_nn(
	id SERIAL PRIMARY KEY,
	tag TEXT NOT NULL
);

INSERT INTO table_nn (tag) VALUES ('PRATIK');
INSERT INTO table_nn (tag) VALUES (NULL); -- WILL THROW ERROR


-- HOW TO SET NULL CONSTRAINT AFTER TABLE IS BEING CREATED

ALTER TABLE table_nn
ADD COLUMN tag2 TEXT; -- NOT SPECIFING CONSTRAINTS HERE


UPDATE table_nn
SET
	tag2 = 'TALAVIYA' 
WHERE id = 1;


-- BEFORE RUNNING BELOW QUERY WE NEED TO ADD DATA TO THAT COLUMN 

ALTER TABLE table_nn
ALTER COLUMN tag2 SET NOT NULL; -- PRIOR IT WAS GIVING ERROR OF NULL VALUE PRESENT IN COLUMN


UPDATE table_nn
SET
	tag2 = NULL
WHERE id = 1; -- WILL THROW ERROR


SELECT * FROM table_nn;


-- UNIQUE Constraint


CREATE TABLE table_emails(
	id SERIAL PRIMARY KEY,
	emails TEXT UNIQUE
);


INSERT INTO table_emails (emails)
VALUES ('pt@gamil.com');

INSERT INTO table_emails (emails)
VALUES ('pjt@gamil.com');

INSERT INTO table_emails (emails)
VALUES ('pt@gamil.com'); -- this will throw error


SELECT *
FROM table_emails;

-- now first adding column to this table and the adding constraint

ALTER TABlE table_emails
ADD COLUMN tag TEXT;

ALTER TABLE table_emails
ADD CONSTRAINT unique_tag UNIQUE(tag);

SELECT *
FROM table_emails;

UPDATE table_emails
SET
	tag = 'ads'
WHERE 
	id = 1;

UPDATE table_emails
SET
	tag = 'ads' -- this will throw error
WHERE 
	id = 2;



-- we can add same unique constraint to multiple column and combination of that column must be unique

CREATE TABLE table_products(
	id SERIAL PRIMARY KEY,
	product_code VARCHAR(10),
	product_name TEXT
);


-- NOW ADDING UNIQUE CONSTRAINT

ALTER TABLE table_products
ADD CONSTRAINT unique_product UNIQUE(product_code, product_name);

-- now product_code and product_name 's combination must be unique single column values can repeat

INSERT INTO table_products (product_code, product_name) VALUES ('A', 'Apple');
INSERT INTO table_products (product_code, product_name) VALUES ('A1', 'Apple');
INSERT INTO table_products (product_code, product_name) VALUES ('Apple', 'A');
INSERT INTO table_products (product_code, product_name) VALUES ('Apple', 'A1');
-- above insert's will work because combination of them is unique weather single value in column are repeating

INSERT INTO table_products (product_code, product_name) VALUES ('Apple', 'A1'); -- this will throw error



SELECT *
FROM table_products;



-- DEFAULT Constraint

ALTER TABLE table_products
ADD COLUMN is_available VARCHAR(2); --DEFAULT 'Y'
-- We can specify default value above also as DEFAULT 'Y'


ALTER TABLE table_products
ALTER COLUMN is_available SET DEFAULT 'Y';

INSERT INTO table_products (product_code, product_name) VALUES ('A', 'Ball');

SELECT * FROM table_products;


-- Drop Default 

ALTER TABLE table_products
ALTER COLUMN is_available DROP DEFAULT;


-- PRIMARY KEY Constraint

ALTER TABLE table_products
DROP CONSTRAINT table_products_pkey; -- this is how primary key is saved in postgre 

ALTER TABLE table_products
ADD PRIMARY KEY(id); -- can specify multiple columns as well which will make combination as primary key


-- PRIMARY KEY Constraint on multiple columns

CREATE TABLE t_grades(
	course_id VARCHAR(100) NOT NULL,
	student_id VARCHAR(100) NOT NULL,
	grade INT NOT NULL
	-- PRIMARY KEY (course_id, student_id) -- Composite Key as Primary Key
	-- because no single column is able to identify row/tuple uniquely so combining two columns. 
);

INSERT INTO t_grades (course_id, student_id, grade) VALUES
('MATHS', 'S1', 85),
('PYHSICS', 'S1', 90),
('CHEMSITRY', 'S1', 92),
('MATHS', 'S2', 89),
('PYHSICS', 'S2', 80),
('CHEMSITRY', 'S2', 90);

SELECT *
FROM t_grades;

ALTER TABLE t_grades
ADD PRIMARY KEY (course_id, student_id);

-- Drop key
ALTER TABLE t_grades
	DROP CONSTRAINT t_grades_pkey;

-- Adding key
ALTER TABLE t_grades
	ADD CONSTRAINT t_grades_courseid_studentid_pkey
		PRIMARY KEY (course_id, student_id);



-- FOREIGN KEY Constraint

-- NEED TO DEFINE CHILD TABLE FIRST TO USE AS REFERENCE IN PARENT TABLE

CREATE TABLE t_supplier(
	supplier_id INT PRIMARY KEY,
	supplier_name VARCHAR(100) NOT NULL
);

CREATE TABLE t_products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100) NOT NULL,
	supplier_id INT NOT NULL,
	FOREIGN KEY (supplier_id) REFERENCES t_supplier (supplier_id) -- ON DELETE CASCADE
);


-- While inserting data we should first insert data in foreign table (child table),
-- then in parent table because we are referencing data from foreign table,
-- if there will be no data in foreign table than what will we reference to and will give error

INSERT INTO t_supplier (supplier_id, supplier_name) VALUES
(1, 'Supplier1'),
(2, 'Supplier2'),
(3, 'Supplier3');

SELECT *
FROM t_supplier;

INSERT INTO t_products (product_id, product_name, supplier_id) VALUES
(1, 'Pen', 2),
(2, 'Pencil', 1),
(3, 'Paper', 3);

SELECT *
FROM t_products;


INSERT INTO t_products (product_id, product_name, supplier_id) VALUES
(4, 'Scale', 10); -- will give error because there is no supplier with id 10


INSERT INTO t_supplier (supplier_id, supplier_name) VALUES
(10, 'Supplier10');


INSERT INTO t_products (product_id, product_name, supplier_id) VALUES
(4, 'Scale', 10); -- Now this will work


-- works vice versa as well we can't delete supplier if referenced in parent table 
-- first remove the product which is referencing the supplier and then delete supplier

DELETE FROM t_supplier 
WHERE supplier_id = 10; -- will give error

DELETE FROM t_products 
WHERE supplier_id = 10;

-- If you don't want to manually delete records from parent table 
-- then while defining table use ON DELETE CASCADE with foreign key

DELETE FROM t_supplier 
WHERE supplier_id = 10; -- WILL NOT GIVE ERROR


-- Drop foreign key

ALTER TABLE t_products
	DROP CONSTRAINT t_products_supplier_id_fkey;


-- Updating or adding foreign key on existing table

-- for updating drop the existing one and then add new one

ALTER TABLE t_products
 	ADD CONSTRAINT t_products_supplier_id_fkey
	 	FOREIGN KEY (supplier_id) REFERENCES t_supplier (supplier_id);



-- CHECK Constraint

CREATE TABLE staff(
	staff_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	birth_date DATE CHECK (birth_date > '1900-01-01'),
	join_date DATE,
	salary NUMERIC CHECK (salary > 0)
);


-- Drop constraint

ALTER TABLE staff
	DROP CONSTRAINT staff_salary_check;

-- Add constraint

ALTER TABLE staff
	ADD CONSTRAINT staff_check
		CHECK(
			salary > 0
			AND join_date - INTERVAL '18Y' > birth_date 
		);



-- Rename constraint

ALTER TABLE staff
	RENAME CONSTRAINT staff_check TO staff_data_check;


INSERT INTO staff (birth_date, join_date) VALUES
('2002-11-03', '2010-03-11'); -- this will give error 

INSERT INTO staff (birth_date, join_date) VALUES
('2002-11-03', '2022-03-11');


SELECT *
FROM staff;


