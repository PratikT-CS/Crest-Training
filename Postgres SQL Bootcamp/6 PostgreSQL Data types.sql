-- 7 - PostgreSQL Data types

-- Boolean

CREATE TABLE table_boolean(
	product_id SERIAL PRIMARY KEY,
	is_available BOOLEAN NOT NULL
);

INSERT INTO 
	table_boolean (is_available) 
VALUES 
	(TRUE), 
	('true'), 
	('1'), 
	('yes'), 
	('y'),
	('t')
;

INSERT INTO 
	table_boolean (is_available) 
VALUES 
	(FALSE), 
	('false'), 
	('0'), 
	('no'), 
	('n'),
	('f')
;

SELECT * 
FROM table_boolean
;


SELECT *
FROM table_boolean
WHERE 
	is_available
;

SELECT *
FROM table_boolean
WHERE 
	NOT is_available
;


-- Date/Time data types

-- DATE

CREATE TABLE table_dates(
	id SERIAL PRIMARY KEY,
	employee_name VARCHAR(100) NOT NULL,
	hire_date DATE NOT NULL,
	add_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO table_dates (employee_name, hire_date) VALUES
('Pratik', '2025-01-06'),
('Deep', '2025-01-06')
;

SELECT * FROM table_dates;

-- current time, date and timezone
SELECT NOW();

-- current date
SELECT CURRENT_DATE;


-- TIME

CREATE TABLE table_time(
	id SERIAL PRIMARY KEY,
	class_name VARCHAR(100) NOT NULL,
	start_time TIME NOT NULL,
	end_time TIME NOT NULL
);

INSERT INTO table_time (class_name, start_time, end_time) VALUES
('MATHS', '08:00:00', '08:45:00'),
('CHEMISTRY', '08:50:00', '09:35:00'),
('PHYSICS', '09:40:00', '10:25:00')
;

SELECT *
FROM table_time;

-- getting current time
SELECT CURRENT_TIME;

-- getting local time of machine
SELECT LOCALTIME;

-- interval

SELECT
CURRENT_TIME,
CURRENT_TIME + INTERVAL '2 hours';

-- TIMESTAMP and TIMESTAMPTZ


SHOW TIMEZONE;

CREATE TABLE table_time_tz(
	ts TIMESTAMP,
	tstz TIMESTAMPTZ
);

INSERT INTO table_time_tz (ts, tstz) VALUES
(NOW(),'2025-02-05 10:01:40.605672-08' );

SELECT *
FROM table_time_tz;


SET TIMEZONE = 'America/New_York';


-- current timestamp
SELECT CURRENT_TIMESTAMP;

-- change timezone
SET TIMEZONE = 'Asia/Calcutta';

SELECT TIMEOFDAY();



-- UUID

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


SELECT uuid_generate_v1();

SELECT uuid_generate_v4();


CREATE TABLE table_uuid(
	product_id UUID DEFAULT uuid_generate_v1(),
	product_name VARCHAR(100) NOT NULL
);

INSERT INTO table_uuid (product_name) VALUES ('ASADFDRfDF');
SELECT * FROM table_uuid;

ALTER TABLE table_uuid
ALTER COLUMN product_id
SET DEFAULT uuid_generate_v4();


-- ARRAY

CREATE TABLE table_array(
	id SERIAL,
	name VARCHAR(100),
	phone TEXT[]
);

INSERT INTO table_array (name, phone) VALUES
('Pratik', ARRAY['8234789234', '9876252132']),
('Aditya', ARRAY['7432234221', '8923412343']);

SELECT *
FROM table_array;

SELECT 
	name,
	phone [1]
FROM 
	table_array;


SELECT 
	name,
	phone [2]
FROM 
	table_array;



-- hstore

CREATE EXTENSION IF NOT EXISTS hstore;

CREATE TABLE table_hstore(
	id SERIAL PRIMARY KEY,
	book_title VARCHAR(100) NOT NULL,
	book_info hstore
);

INSERT INTO table_hstore (book_title, book_info) VALUES
(
	'Title 2',
	'
		"publisher" => "XYZ Publishers",
		"cost" => "500",
		"e_cost" => "100"
	'
);

SELECT *
FROM table_hstore;

SELECT 
	book_title,
	book_info -> 'publisher' AS "Publisher",
	book_info -> 'e_cost' AS "Electornic Cost"
FROM 
	table_hstore;


SELECT 
	book_title,
	book_info -> 'publisher' AS "Publisher",
	book_info -> 'e_cost' AS "Electornic Cost"
FROM 
	table_hstore
WHERE
	book_info -> 'e_cost' = '100'
;


-- JSON

CREATE TABLE table_json(
	id SERIAL PRIMARY KEY,
	docs JSON
);

INSERT INTO table_json (docs) VALUES
('[1, 2, 3, 4, 5, 6]'),
('[2, 3, 4, 5, 6, 7]'),
('{"key" : "value" }');

SELECT *
FROM table_json;

SELECT *
FROM table_json
WHERE
	docs @> '2';

ALTER TABLE table_json
ALTER COLUMN docs TYPE JSONB;

CREATE INDEX ON table_json USING GIN (docs jsonb_path_ops);




-- Network Addresses

CREATE TABLE table_netaddr (
	id SERIAL PRIMARY KEY,
	ip INET
);


INSERT INTO table_netaddr (ip) VALUES
('192.168.1.1'),
('10.0.0.1'),
('172.16.0.100');

SELECT *
FROM table_netaddr;

SELECT 
	ip,
	set_masklen(ip, 24) AS inet_24,
	set_masklen(ip::cidr, 24) AS cidr_24,
	set_masklen(ip::cidr, 26) AS cidr_26,
	set_masklen(ip::cidr, 28) AS cidr_28
FROM table_netaddr;


















