-- PostgreSQL Schemas

CREATE SCHEMA hr;

CREATE SCHEMA sales;

-- renaming schema

ALTER SCHEMA sales RENAME TO programming;

-- drop schema

DROP SCHEMA programming;


-- view current schema

SELECT current_schema();

-- view current search path

SHOW search_path;

-- set new schema to search path to avoid writing schema.tablename every time

SET search_path TO '$user', hr, public;

SHOW search_path;


-- change owner of schema

ALTER SCHEMA hr OWNER TO "Pratik";



-- create duplicate scheam in different database

-- first step is to create dump file
-- we have to run this command in terminal

pg_dump -d hr -h localhost -U postgres -n public > dump_hr.sql


-- granting permission to users

GRANT USAGE ON SCHEMA sales TO "Pratik";

-- granting permission to access tables of the schema

GRANT SELECT ON ALL TABLES IN SCHEMA sales TO "Pratik";


-- grant permission to create tables in the schema

GRANT CREATE ON SCHEMA sales TO "Pratik";

