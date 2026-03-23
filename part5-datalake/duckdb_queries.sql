-- ============================================================
-- DuckDB Cross-Format Queries (Data Lake)
-- ============================================================

### 📂 Part 5: Data Lake & DuckDB

-- High-performance "zero-copy" SQL queries performed directly on CSV, JSON, and Parquet files.

-- I executed duckDB at `cmd` terminal to run my duckDB queries
-- All 3 datsets and sql-query file must be in the current directory.
-- Execute the following command at duckDB prompt `D`
-- .read duckdb_queries.sql

-- Q1: List all customers along with the total number of orders they have placed
-- Requirement: Includes Customer ID (ID) and Name.
SELECT 
    c.customer_id AS "Cust ID",
    c.name AS "Customer Name", 
    COUNT(o.order_id) AS "Their total-num-of-orders"
FROM read_csv_auto('customers.csv') AS c
LEFT JOIN read_json_auto('orders.json') AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


-- Q2: Find the top 3 customers by total order value
-- Requirement: Includes Customer ID (ID) and Name.
SELECT 
    c.customer_id AS "Cust ID",
    c.name AS "Top 3 Customers", 
    SUM(o.total_amount) AS "Their total-spends"
FROM read_csv_auto('customers.csv') AS c
JOIN read_json_auto('orders.json') AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY "Their total-spends" DESC
LIMIT 3;


-- Q3: List all products purchased by customers from Bangalore
-- Requirement: Only the product names.
SELECT DISTINCT 
    p.product_name AS "Products Purchased by customers in Bangalore"
FROM read_parquet('products.parquet') AS p
CROSS JOIN read_json_auto('orders.json') AS o
JOIN read_csv_auto('customers.csv') AS c ON o.customer_id = c.customer_id
WHERE c.city = 'Bangalore';


-- Q4: Join all three files to show: customer name, order date, product name, and quantity
-- Requirement: Full report without Customer ID.
SELECT 
    c.name AS "All Customers", 
    o.order_date AS "Date", 
    p.product_name AS "Product", 
    o.num_items AS "Qty"
FROM read_json_auto('orders.json') AS o
JOIN read_csv_auto('customers.csv') AS c ON o.customer_id = c.customer_id
CROSS JOIN read_parquet('products.parquet') AS p;