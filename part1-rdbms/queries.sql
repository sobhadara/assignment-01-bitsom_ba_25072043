-- Q1: List all customers from Mumbai along with their total order value
-- Note: Uses SUM and JOINs to combine Customer, Order, and Product data.
SELECT 
    c.customer_name AS "Customer Name", 
    COALESCE(SUM(o.quantity * p.unit_price), 0) AS "Total Order Value"
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Products p ON o.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_name;


-- Q2: Find the top 3 products by total quantity sold
-- Note: Groups by product name and sorts by the highest total quantity.
SELECT 
    p.product_name AS "Product Name", 
    SUM(o.quantity) AS "Total Quantity Sold"
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY "Total Quantity Sold" DESC
LIMIT 3;


-- Q3: List all sales representatives and the number of unique customers they have handled
-- Note: Uses LEFT JOIN so even reps with zero customers are listed.
SELECT 
    s.sales_rep_name AS "Sales Representative", 
    COUNT(DISTINCT o.customer_id) AS "Unique Customers Handled"
FROM SalesReps s
LEFT JOIN Orders o ON s.sales_rep_id = o.sales_rep_id
GROUP BY s.sales_rep_name;


-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
-- Note: Calculates value on the fly and filters the results.
-- Returns "None" if no results found.
SELECT 
    o.order_id AS "Order ID", 
    CAST((o.quantity * p.unit_price) AS VARCHAR) AS "Order Value"
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
WHERE (o.quantity * p.unit_price) > 10000

UNION ALL

-- This part only runs if the first part returns 0 rows
SELECT 'None', '0.00'
WHERE NOT EXISTS (
    SELECT 1 
    FROM Orders o
    JOIN Products p ON o.product_id = p.product_id
    WHERE (o.quantity * p.unit_price) > 10000
)
ORDER BY "Order Value" DESC;

-- Q5: Identify any products that have never been ordered
-- Note: Uses a LEFT JOIN to find products that do not exist in the Orders table.
SELECT 
    p.product_name AS "Products Never Ordered"
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;