-- querying the database
USE ecommerce;

-- Retrieve the complete product catalogue for an initial overview of product data
SELECT * 
FROM product;

-- Retrieve products with a unit price of £50 or more
SELECT * 
FROM product
	WHERE unit_price >= 50;
    
 -- Retrieve products ordered with the most expensive listed first
 SELECT * 
 FROM product
	ORDER BY unit_price DESC;
    
-- Retrieve products with a unit price below £50, with the cheapest listed first
SELECT * 
FROM product
	WHERE unit_price < 50
    ORDER BY unit_price ASC;
    
-- Retrieve each product's current price and show the price after a 10% increase
SELECT 	product_name, 
		unit_price, 
        ROUND(unit_price * 1.1,2) AS price_after_increase 
FROM product;

-- Retrieve each product's current price and 10% price increase, with the highest increase listed first
SELECT 	product_name, 
		unit_price AS current_price, 
        ROUND(unit_price * 0.1,2) AS price_increase 
FROM product 
	ORDER BY price_increase DESC;
    
-- Retrieve customers contacted by email in alphabetical order by last name
SELECT  customer_fname AS customer_first_name, 
		customer_lname AS customer_last_name,
		city,
		preferred_comms_method 
FROM customer
	WHERE preferred_comms_method = 'Email'
    ORDER BY customer_lname;

-- Retrieve the total number of orders
SELECT COUNT(*) AS customer_orders 
FROM customer_order;

-- Retrieve the number of orders per customer
SELECT customer_id, COUNT(*) AS customer_orders 
FROM customer_order
	GROUP BY customer_id;

-- Retrieve the number of orders per customer, displaying customer names
SELECT  CONCAT(c.customer_fname, ' ', c.customer_lname) AS customer_name, 
		COUNT(*) AS customer_orders 
FROM customer_order co
    INNER JOIN customer c
		ON c.customer_id = co.customer_id
	GROUP BY c.customer_id
    ORDER BY customer_name ASC;

-- Retrieve customers who have placed more than one order
SELECT  CONCAT(c.customer_fname, ' ', c.customer_lname) AS customer_name, 
		COUNT(*) AS customer_orders 
FROM customer_order co
    INNER JOIN customer c
		ON c.customer_id = co.customer_id
	GROUP BY c.customer_id
    HAVING COUNT(*) > 1
    ORDER BY customer_name ASC;

-- Retrieve the quantity of each product across all inventory locations
SELECT  product_id, 
		SUM(quantity) AS total_units_stock 
FROM product_location
	GROUP BY product_id;
    
-- Retrieve the quantity of each product across all inventory locations, with the greatest quantity listed first
SELECT  p.product_name, 
		SUM(pl.quantity) AS total_units_stock 
FROM product p
    INNER JOIN product_location pl
		ON p.product_id = pl.product_id
	GROUP BY p.product_id
    ORDER BY SUM(pl.quantity) DESC;
    
-- Retrieve each product, its supplier and the unit cost each supplier charges, with the cheapest supplier for each product listed first
 SELECT p.product_name, 
		s.supplier_name, 
        sp.unit_cost 
FROM supplier s
    INNER JOIN supplier_product sp
		ON s.supplier_id = sp.supplier_id
	INNER JOIN product p
		ON p.product_id = sp.product_id
	ORDER BY   p.product_name, sp.unit_cost  ASC;

-- Retrieve the number of product units sold in each order, with the greatest quantity listed first
SELECT  order_id, 
		SUM(quantity) AS quantity_ordered 
FROM order_products
	GROUP BY order_id
    ORDER BY SUM(quantity) DESC;
    
-- Retrieve the total value of each order, with the highest-value listed first       
SELECT  order_id, 
		SUM(unit_price * quantity) AS total_order_value 
FROM order_products op
	INNER JOIN product p
		ON p.product_id = op.product_id
	GROUP BY order_id
    ORDER BY total_order_value DESC;
    
-- Retrieve the customer name and total value for each order, with the highest-value order listed first
SELECT  co.order_id, 
		CONCAT(c.customer_fname, ' ', c.customer_lname) AS customer,  
		SUM(unit_price * quantity) AS total_order_value
FROM order_products op
	INNER JOIN product p
		ON p.product_id = op.product_id
	INNER JOIN customer_order co
		ON co.order_id = op.order_id
	INNER JOIN customer c
		ON c.customer_id = co.customer_id
	GROUP BY co.order_id
    ORDER BY total_order_value DESC;
    
-- Retrieve total spend by customer across all their orders, with highest spending listed first
SELECT  CONCAT(c.customer_fname, ' ', c.customer_lname) AS customer,
		SUM(unit_price * quantity) AS total_expenditure
FROM order_products op
	INNER JOIN product p
		ON p.product_id = op.product_id
	INNER JOIN customer_order co
		ON co.order_id = op.order_id
	INNER JOIN customer c
		ON c.customer_id = co.customer_id
	GROUP BY c.customer_id
	ORDER BY SUM(unit_price * quantity) DESC;

-- Retrieve customers where total spend is greater than £150, with highest spend listed first
SELECT  CONCAT(c.customer_fname, ' ', c.customer_lname) AS customer,
		SUM(unit_price * quantity) AS total_expenditure
FROM order_products op
	INNER JOIN product p
		ON p.product_id = op.product_id
	INNER JOIN customer_order co
		ON co.order_id = op.order_id
	INNER JOIN customer c
		ON c.customer_id = co.customer_id
	GROUP BY c.customer_id
    HAVING SUM(unit_price * quantity) > 150
    ORDER BY SUM(unit_price * quantity) DESC;
    
-- Retrieve the average unit cost for each product that is supplied by more than one supplier
SELECT  p.product_name, 
		COUNT(s.supplier_id) AS suppliers_by_product,
        ROUND(AVG(sp.unit_cost),2) AS avg_supplier_cost
FROM product p
    INNER JOIN supplier_product sp
		ON p.product_id = sp.product_id
    INNER JOIN supplier s
		ON sp.supplier_id = s.supplier_id
    GROUP BY p.product_id
		HAVING COUNT(s.supplier_id) > 1;
        
-- Retrieve the difference between the cheapest and most expensive supplier quote by product
SELECT  p.product_name,
		MIN(sp.unit_cost) AS cheapest_supplier_cost,
        MAX(sp.unit_cost) AS highest_supplier_cost,
        MAX(sp.unit_cost) - MIN(sp.unit_cost) AS difference
FROM product p
    INNER JOIN supplier_product sp
		ON p.product_id = sp.product_id
	GROUP BY p.product_id
    HAVING COUNT(supplier_id) > 1;
    
-- Retrieve products with total revenue above £75, with highest revenue listed first
SELECT p.product_name, 
		SUM(op.quantity * p.unit_price) AS total_revenue_by_product
FROM product p
    INNER JOIN order_products op
		ON p.product_id = op.product_id
	GROUP BY p.product_id
	HAVING SUM(op.quantity * p.unit_price) > 75
	ORDER BY SUM(op.quantity * p.unit_price) DESC;