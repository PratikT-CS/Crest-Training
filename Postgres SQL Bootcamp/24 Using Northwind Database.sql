-- Using Northwind Database


-- orders shipped to usa or france

SELECT *
FROM 
	orders
WHERE 
	ship_country = 'USA'
	OR ship_country = 'France'
;


-- count of orders from shipped countries

SELECT
	ship_country,
	COUNT(*)
FROM 
	orders
WHERE
	ship_country = 'USA'
	OR ship_country = 'France'
GROUP BY
	ship_country
;


-- total order amount

SELECT * 
FROM order_details;

SELECT 
	order_id, 
	product_id, 
	unit_price, 
	quantity, 
	discount, 
	(unit_price * quantity) - discount AS "Amount"
FROM 
	order_details
;


-- first and latest order date

SELECT 
	MIN(order_date) AS "First Order",
	MAX(order_date) AS "Latest Order"
FROM 
	orders;


SELECT 
	MIN(quantity) AS "Min Qty",
	MAX(quantity) AS "Max Qty"
FROM 
	order_details;


-- Total products in each categries

SELECT 
	categories.category_name,
	COUNT(*)
FROM products
INNER JOIN 
	categories USING(category_id) 
GROUP BY 
	categories.category_name
;


-- List products that needs reordering

SELECT *
FROM 
	products
WHERE 
	units_in_stock <= reorder_level
;


-- Customers with no orders

SELECT 
	c.customer_id, 
	c.company_name
FROM customers AS c
LEFT JOIN 
	orders AS o USING (customer_id)
WHERE 
	o.order_id IS NULL
;



-- Top customers based on total order amount

SELECT 
	c.customer_id, 
	c.company_name,
	SUM((od.unit_price * od.quantity) - od.discount) AS "Total Amount"
FROM 
	customers AS c
INNER JOIN 
	orders AS o USING (customer_id)
INNER JOIN 
	order_details AS od USING (order_id)
GROUP BY 
	c.customer_id
ORDER BY 3 DESC
LIMIT 10
;


-- Orders with many line items

SELECT 
	order_id, 
	COUNT(*)
FROM 
	order_details
GROUP BY 
	order_id
HAVING COUNT(*) > 1
ORDER BY 2 DESC
;


-- COUNTRIES WITH CUSTOMERS OR SUPPLIERS

-- WITH UNION

SELECT 
	country
FROM 
	customers
UNION
SELECT 
	country
FROM 
	suppliers
ORDER BY 
	country
;


SELECT 
	DISTINCT country
FROM 
	customers
UNION ALL
SELECT 
	DISTINCT country
FROM 
	suppliers
ORDER BY 
	country;



-- WITH CTE

WITH countries_customers AS
(
	SELECT 
		DISTINCT country
	FROM 
		customers
),
countries_suppliers AS
(
	SELECT 
		DISTINCT country
	FROM 
		suppliers
)
SELECT 
	cc.country AS "Customers Countries",
	cs.country AS "Suppliers Countries"
FROM 
	countries_customers AS cc
FULL JOIN 
	countries_suppliers AS cs USING (country)
;


-- CUSTOMERS WITH MULTIPLE ORDERS

WITH next_order_date AS
(
	SELECT 
		customer_id, 
		order_date,
		LEAD(order_date, 1) 
			OVER (PARTITION BY customer_id 
			ORDER BY customer_id, order_date) 
			AS next_order_date
	FROM 
		orders
)
SELECT 
	customer_id, 
	order_date, 
	next_order_date,
	(next_order_date - order_date) AS days_between_orders
FROM 
	next_order_date
WHERE 
	(next_order_date - order_date) <= 4
;


-- FIRST ORDER FROM EACH COUNTRY

SELECT 
	ship_country, 
	MIN(order_date) AS "First Order"
FROM 
	orders
GROUP BY 
	ship_country
;


WITH orders_by_country AS
(
	SELECT 
		ship_country, 
		order_id, 
		order_date,
		ROW_NUMBER() 
			OVER (PARTITION BY ship_country 
				ORDER BY ship_country, order_date) 
				AS country_row_number
	FROM 
		orders
)
SELECT 		
	ship_country, 
	order_id, 
	order_date
FROM 
	orders_by_country
WHERE 
	country_row_number = 1
;






