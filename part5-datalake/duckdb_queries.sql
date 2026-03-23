-- ============================================================
-- DuckDB Cross-Format Queries (Data Lake)
-- ============================================================



-- Q1: List all customers along with total number of orders they have placed
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('customers.csv') c
LEFT JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;


-- Q2: Find the top 3 customers by total order value
SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_order_value
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_order_value DESC
LIMIT 3;


-- Q3: List all products purchased by customers from Bangalore
-- NOTE: orders.json does not contain product_id
-- CROSS JOIN used as workaround
SELECT DISTINCT 
    c.name,
    p.product_name
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
CROSS JOIN read_parquet('products.parquet') p
WHERE c.city = 'Bangalore';


-- Q4: Join all three files to show customer name, order date, product name, and quantity
-- NOTE: num_items used as proxy for quantity
SELECT 
    c.name,
    o.order_date,
    p.product_name,
    o.num_items AS quantity
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
CROSS JOIN read_parquet('products.parquet') p;