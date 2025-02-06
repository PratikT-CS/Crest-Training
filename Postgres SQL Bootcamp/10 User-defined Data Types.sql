-- User defined Data types

CREATE DOMAIN addr VARCHAR(100) NOT NULL;

CREATE TABLE locations(
	address addr
);

INSERT INTO locations (address) VALUES ('123 SURAT');

SELECT * 
FROM locations; 

-- Postive Number

CREATE DOMAIN positive_numeric INT NOT NULL CHECK (VALUE > 0);

CREATE TABLE sample(
	sample_id SERIAL PRIMARY KEY,
	value_num positive_numeric
);

INSERT INTO sample (value_num) VALUES (3), (6), (9);
INSERT INTO sample (value_num) VALUES (-1);


SELECT *
FROM sample;

-- Postal code 

CREATE DOMAIN us_postal_code TEXT
CHECK(
	VALUE ~'^\d{5}$'
	OR VALUE ~'\d{5}-\d{4}$'
);


CREATE TABLE addresses(
	address_id SERIAL PRIMARY KEY,
	postal_code us_postal_code
);

INSERT INTO addresses (postal_code) VALUES (23523);
INSERT INTO addresses (postal_code) VALUES (23523-2343);
INSERT INTO addresses (postal_code) VALUES (23523-ASDG);
INSERT INTO addresses (postal_code) VALUES (235235);
INSERT INTO addresses (postal_code) VALUES (23523-34562);

SELECT *
FROM addresses;

-- Drop a domain


DROP DOMAIN addr; -- this throws and error that it is being used in some table

DROP DOMAIN addr CASCADE; --this will work and will also delete the column where this domain is being used 

-- best practice is to alter the type of that particular column and then drop it.
ALTER TABLE locations
ALTER COLUMN address TYPE VARCHAR(100);

DROP DOMAIN addr CASCADE; -- NO NEED TO USE CASCADE AS this domain is not in use
DROP DOMAIN addr;










-- Composite data types

CREATE TYPE address AS (
	city VARCHAR(50),
	country VARCHAR(20)
);

CREATE TABLE companies(
	comp_id SERIAL PRIMARY KEY,
	address address
);

INSERT INTO companies (address) VALUES (ROW('Surat', 'India')); -- use ROW() TO INSERT DATA 
INSERT INTO companies (address) VALUES (ROW('New Delhi', 'India'));
INSERT INTO companies (address) VALUES (ROW('Mumbai', 'India'));

SELECT *
FROM companies;

SELECT 
	address,
	(address).city AS city,
	(address).country AS country
FROM 
	companies;


SELECT 
	address,
	(companies.address).city AS city, -- (tablename.column_name).field use this when working  
	(companies.address).country AS country -- with multiple tables in joins 
FROM 
	companies;


-- Creating type with enum

CREATE TYPE currency AS ENUM('INR', 'USD', 'EUR');

ALTER TYPE currency ADD VALUE 'CHF' AFTER 'USD';


CREATE TABLE stocks(
	stock_id SERIAL PRIMARY KEY,
	stock_currency currency
);


INSERT INTO stocks (stock_currency) VALUES ('INR');
INSERT INTO stocks (stock_currency) VALUES ('IN');
INSERT INTO stocks (stock_currency) VALUES ('USD');

SELECT * FROM stocks;


-- Drop type
-- Similar to domain drop can only drop if it is not in use or with CASCADE which deletes the column as well
-- where type is being used.

DROP TYPE address; -- this will give error and will suggest use of cascade

CREATE TYPE sample_type AS ENUM ('abc', 'ABC');

DROP TYPE sample_type; -- if not used any where then can delete it without using cascade



-- Alter the composite data type

CREATE TYPE myaddress AS (
	city VARCHAR(50),
	country VARCHAR(20)
);


ALTER TYPE myaddress 
RENAME TO my_address;

ALTER TYPE my_address
OWNER TO postgres;


-- create new schema

CREATE SCHEMA test_schema;

-- alter schema of type

ALTER TYPE my_address SET SCHEMA test_schema;

-- adding attribute to composite data type

ALTER TYPE my_address ADD ATTRIBUTE street_address VARCHAR(150); -- By Default it is public schema

ALTER TYPE test_schema.my_address ADD ATTRIBUTE street_address VARCHAR(150); -- here we have give the schema


-- Altering Enum data type 

CREATE TYPE colors AS ENUM ('red', 'green', 'blue');


-- Renaming the value in enum

ALTER TYPE colors RENAME VALUE 'red' to 'orange';


-- Select/list all values of enum

SELECT enum_range(NULL::colors);


-- adding value before or after a specific value

ALTER TYPE colors ADD VALUE 'red' BEFORE 'green';
ALTER TYPE colors ADD VALUE 'purple' AFTER 'green';



-- Default value from enum in column of table

CREATE TABLE color(
	color_id INT,
	color colors DEFAULT 'green'
);


INSERT INTO color (color_id) VALUES (1);
INSERT INTO color (color_id, color) VALUES (2, 'orange');
INSERT INTO color (color_id) VALUES (3);

SELECT *
FROM color;



















