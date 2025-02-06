-- PostgreSQL Sequences

-- Creating sequence

CREATE SEQUENCE IF NOT EXISTS test_seq;

-- acessing val

SELECT nextval('test_seq'); -- this give incremented value

-- current val

SELECT currval('test_seq'); -- this will give last value produced means current value without incrementing

-- set val

SELECT setval('test_seq', 33);

SELECT nextval('test_seq'); -- will start from 33 now means 34 is answer


SELECT setval('test_seq', 333, false); -- now nextval() will produce 333 not 334 


-- Creating sequence with specifying start value

CREATE SEQUENCE IF NOT EXISTS test_seq2 START WITH 100;

SELECT nextval('test_seq2');


-- Rename Sequence

ALTER SEQUENCE test_seq2
RENAME TO my_sequence;

-- Restart the sequence

ALTER SEQUENCE my_sequence RESTART 10;

SELECT nextval('my_sequence');


-- Create a sequence with START WITH, INCREMENT, MINVALUE and MAXVALUE

CREATE SEQUENCE IF NOT EXISTS test_seq2
START WITH 500
INCREMENT 50
MINVALUE 500
MAXVALUE 50000
;

SELECT nextval('test_seq2');


-- Create a sequence using a specific data type

CREATE SEQUENCE IF NOT EXISTS test_smallint AS SMALLINT;
CREATE SEQUENCE IF NOT EXISTS test_int AS INT;

-- Creating a descending sequence, and CYCLE sequence

CREATE SEQUENCE IF NOT EXISTS seq_des
INCREMENT -1
MINVALUE 1
MAXVALUE 10
START 10
CYCLE; 

-- cycle restart when minvalue is reached again with start value
-- if NO CYCLE is used then on reaching the minvalue after that call nextval() will give error

SELECT nextval('seq_des');


-- DELETE A SEQUENCE

DROP SEQUENCE test_seq;

-- to add sequence to table just set DEFAULT nextval('seq_name') done 
-- no need to use sequence name as data type in column


-- alphanumeric sequence

SELECT ('ID' || nextval('test_int'));

CREATE SEQUENCE IF NOT EXISTS alp_seq;

CREATE TABLE contacts(
	contact_id TEXT NOT NULL DEFAULT ('ID' || nextval('alp_seq')),
	contact_name VARCHAR(50)
);

ALTER SEQUENCE alp_seq OWNED BY contacts.contact_id;

INSERT INTO contacts (contact_name) VALUES
('PRATIK'),
('DEEP'),
('ADITYA'),
('KARAN');

SELECT *
FROM contacts;


