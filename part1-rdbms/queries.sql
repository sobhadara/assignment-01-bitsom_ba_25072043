-- Q1: List all customers from Mumbai along with their total order value
SELECT 
    c.customer_name AS "Customers from Mumbai", 
    SUM(o.quantity * p.unit_price) AS "Total Order Value"
FROM Customers C
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Products p ON o.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_name;


-- Q2: Find the top 3 products by total quantity sold
SELECT p.product_name AS "PRODUCT", SUM(o.quantity) AS Total_QTY_Sold
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY Total_QTY_Sold DESC
LIMIT 3;


-- Q3: List all sales representatives and the number of unique customers they have handled
SELECT s.sales_rep_name AS "Sales Representative", COUNT(DISTINCT o.customer_id) AS "Unique Customers they held"
FROM SalesReps s
LEFT JOIN Orders o ON s.sales_rep_id = o.sales_rep_id
GROUP BY s.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
-- Select the actual data
SELECT order_id, (quantity * unit_price) AS "total_value > 10000"
FROM Orders JOIN Products ON Orders.product_id = Products.product_id
WHERE (quantity * unit_price) > 10000

UNION ALL

-- Select a dummy row only if the first query returns nothing
SELECT 'No results', 0
WHERE NOT EXISTS (
    SELECT 1 FROM Orders JOIN Products ON Orders.product_id = Products.product_id
    WHERE (quantity * unit_price) > 10000
);

-- Q5: Identify any products that have never been ordered
SELECT p.product_name AS products_never_ordered
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;
