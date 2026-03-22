-- Q1: Total sales revenue by product category for each month
SELECT 
    d.year AS "Year",
    d.month AS "Month",
    p.category AS "Product Category",
    SUM(f.total_amount) AS "Total Revenue"
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY d.year, d.month, p.category
ORDER BY d.year, d.month, "Total Revenue" DESC;


-- Q2: Top 2 performing stores by total revenue
SELECT 
    s.store_name AS "Store Name",
    s.store_city AS "City",
    SUM(f.total_amount) AS "Total Revenue"
FROM fact_sales f
JOIN dim_store s ON f.store_key = s.store_key
GROUP BY s.store_name, s.store_city
ORDER BY "Total Revenue" DESC
LIMIT 2;


-- Q3: Month-over-month sales trend across all stores
SELECT 
    d.year AS "Year",
    d.month AS "Month",
    SUM(f.total_amount) AS "Monthly Revenue Trend"
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month ASC;