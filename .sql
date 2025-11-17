-- Task 3: SQL Queries for Ecommerce Database
-- This file contains sample SQL queries for analysis on ecommerce.db

-- 1. List all customers from India
SELECT * FROM customers WHERE country='India';

-- 2. Total spent by each customer
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;

-- 3. List all orders with customer names
SELECT o.order_id, c.first_name, c.last_name, o.order_date, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 4. Top 5 most expensive products
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- 5. Products ordered more than 1 time
SELECT product_id, SUM(quantity) AS total_ordered
FROM order_items
GROUP BY product_id
HAVING total_ordered > 1;

-- 6. Total quantity sold per product
SELECT p.product_name, SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

-- 7. Orders placed on 2025-11-17
SELECT * FROM orders WHERE order_date='2025-11-17';

-- 8. Create a view for customer total spending
CREATE VIEW customer_total_spent AS
SELECT c.customer_id, c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 9. Query the view
SELECT * FROM customer_total_spent ORDER BY total_spent DESC;

-- 10. Add an index on customer_id in orders table to speed up queries
CREATE INDEX idx_orders_customer_id ON orders(customer_id);