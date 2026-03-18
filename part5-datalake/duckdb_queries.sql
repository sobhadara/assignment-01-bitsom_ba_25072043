-- ============================================================================
-- Part 5.1 — DuckDB Data Lake Queries
-- ============================================================================
-- HOW TO RUN THESE QUERIES: 
--   ENSURE ALL FILES ARE IN THE SAME CURRENT FOLDER
--
-- Option 1 (From Mac Terminal):
--   duckdb -column -header -c ".read duckdb_queries.sql"
--
-- Option 2 (From inside DuckDB Shell 'D' prompt):
--   .read duckdb_queries.sql
-- ============================================================================

-- Q1: List all customers along with the total number of orders placed
-- Using read_csv_auto and read_json_auto for automatic schema detection.
SELECT 
    c.customer_id,
    c.name, 
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('customers.csv') AS c
LEFT JOIN read_json_auto('orders.json') AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- Q2: Find the top 3 customers by total order value
-- Aggregates 'total_amount' from orders.json for each customer in customers.csv.
SELECT 
    c.customer_id,
    c.name, 
    SUM(o.total_amount) AS total_order_value
FROM read_csv_auto('customers.csv') AS c
JOIN read_json_auto('orders.json') AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_order_value DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
-- Uses a CROSS JOIN as orders.json does not contain a product_id field.
SELECT DISTINCT 
    p.product_name
FROM read_parquet('products.parquet') AS p
CROSS JOIN read_json_auto('orders.json') AS o
JOIN read_csv_auto('customers.csv') AS c ON o.customer_id = c.customer_id
WHERE c.city = 'Bangalore';

-- Q4: Join all three files to show: customer name, order date, product name, and quantity
-- Maps 'num_items' from the JSON file to the 'quantity' alias.
SELECT 
    c.name AS customer_name, 
    o.order_date, 
    p.product_name, 
    o.num_items AS quantity
FROM read_csv_auto('customers.csv') AS c
JOIN read_json_auto('orders.json') AS o ON c.customer_id = o.customer_id
CROSS JOIN read_parquet('products.parquet') AS p;
