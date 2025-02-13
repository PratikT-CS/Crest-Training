-- Indexes and Performance Optimaization

-- Creating an Index

-- single column

CREATE INDEX idx_orders_order_date 
ON orders (order_date);

CREATE INDEX idx_orders_ship_city
ON orders (ship_city);

-- multiple column

CREATE INDEX idx_orders_customer_id_order_id 
ON orders (customer_id, order_id);



-- create unique index on primary key

CREATE UNIQUE INDEX idx_u_products_product_id 
ON products (product_id);


-- unique index on multiple columns

CREATE UNIQUE INDEX idx_u_orders_customer_id_order_id
ON orders (customer_id, order_id);


-- list all pg indexes

SELECT *
FROM pg_indexes
WHERE 	
	schemaname = 'public' 
;

-- for specific tables

SELECT *
FROM pg_indexes
WHERE 	
	schemaname = 'public' 
	AND tablename = 'orders';


-- command to check size of indexes created for specific table

SELECT
	pg_size_pretty(pg_indexes_size('orders'))
;


SELECT
	pg_size_pretty(pg_indexes_size('suppliers')) 
; -- here there are no indexes create by us yet but still it has taken 16 kB for some predefined stuff



-- stats for all the index 

SELECT *
FROM pg_stat_all_indexes
;

-- stats of index for praticular schemas

SELECT *
FROM
	pg_stat_all_indexes
WHERE 
	schemaname = 'public'
;

-- stats of indexes for particular tables

SELECT *
FROM 
 	pg_stat_all_indexes
WHERE
	relname = 'orders'
;


-- drop index

DROP INDEX idx_orders_ship_city;

SELECT *
FROM 
 	pg_stat_all_indexes
WHERE
	relname = 'orders'
;


-- command use to know available node types

SELECT *
FROM pg_am;


-- use explain before query to get additional operational details

EXPLAIN SELECT *
FROM orders;


-- Hash indexing

CREATE INDEX idx_orders_order_date_on
USING hash (order_date)
;

EXPLAIN ( FORMAT JSON )SELECT * -- USED FOR BETTER EXPLAINATION
FROM orders
ORDER BY
	order_date
;

"[
  {
    ""Plan"": {
      ""Node Type"": ""Index Scan"",
      ""Parallel Aware"": false,
      ""Async Capable"": false,
      ""Scan Direction"": ""Forward"",
      ""Index Name"": ""idx_orders_order_date"",
      ""Relation Name"": ""orders"",
      ""Alias"": ""orders"",
      ""Startup Cost"": 0.28,
      ""Total Cost"": 45.73,
      ""Plan Rows"": 830,
      ""Plan Width"": 90
    }
  }
]"


-- Expression Index

CREATE TABLE t_dates AS 
SELECT d, repeat(md5(d::TEXT), 10) AS padding
	FROM generate_series(timestamp '1800-01-01',
		timestamp '2100-01-01', 
		interval '1 day') s(d)
;

SELECT *
FROM t_dates;

VACUUM ANALYZE t_dates;

EXPLAIN ANALYZE
SELECT * 
FROM 
	t_dates
WHERE 
	d BETWEEN '2001-01-01' 
	AND '2001-01-31'
;

"Seq Scan on t_dates  (cost=0.00..6624.61 rows=30 width=332) (actual time=30.115..43.832 rows=31 loops=1)"
"  Filter: ((d >= '2001-01-01 00:00:00'::timestamp without time zone) AND (d <= '2001-01-31 00:00:00'::timestamp without time zone))"
"  Rows Removed by Filter: 109543"
"Planning Time: 0.397 ms"
"Execution Time: 43.860 ms"


-- AFTER INDEXING

CREATE INDEX idx_t_dates_d 
ON t_dates (d);


EXPLAIN ANALYZE
SELECT * 
FROM 
	t_dates
WHERE 
	d BETWEEN '2001-01-01' 
	AND '2001-01-31'
;

"Index Scan using idx_t_dates_d on t_dates  (cost=0.42..10.02 rows=30 width=332) (actual time=0.075..0.081 rows=31 loops=1)"
"  Index Cond: ((d >= '2001-01-01 00:00:00'::timestamp without time zone) AND (d <= '2001-01-31 00:00:00'::timestamp without time zone))"
"Planning Time: 1.916 ms"
"Execution Time: 0.096 ms"



-- without expression index 

EXPLAIN ANALYZE
SELECT *
FROM t_dates
WHERE 
	EXTRACT(day FROM d) = 1;

"Seq Scan on t_dates  (cost=0.00..6624.61 rows=548 width=332) (actual time=0.139..58.866 rows=3601 loops=1)"
"  Filter: (EXTRACT(day FROM d) = '1'::numeric)"
"  Rows Removed by Filter: 105973"
"Planning Time: 0.177 ms"
"Execution Time: 59.053 ms"


-- with expression index

CREATE INDEX idx_expr_t_dates 
ON t_dates (EXTRACT(day FROM d));

ANALYZE t_dates;


EXPLAIN ANALYZE
SELECT *
FROM t_dates
WHERE 
	EXTRACT(day FROM d) = 1
;

"Bitmap Heap Scan on t_dates  (cost=73.26..4972.33 rows=3722 width=332) (actual time=4.731..32.496 rows=3601 loops=1)"
"  Recheck Cond: (EXTRACT(day FROM d) = '1'::numeric)"
"  Heap Blocks: exact=3601"
"  ->  Bitmap Index Scan on idx_expr_t_dates  (cost=0.00..72.33 rows=3722 width=0) (actual time=3.080..3.080 rows=3601 loops=1)"
"        Index Cond: (EXTRACT(day FROM d) = '1'::numeric)"
"Planning Time: 0.892 ms"
"Execution Time: 32.765 ms"

