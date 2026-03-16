-- Q1: Total sales revenue by product category for each month
-- This query helps identify which categories perform best at different times of the year.
SELECT 
    d.year,
    d.month,
    p.category,
    SUM(f.total_amount) AS monthly_category_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY d.year, d.month, p.category
ORDER BY d.year, d.month, monthly_category_revenue DESC;


-- Q2: Top 2 performing stores by total revenue
-- This query identifies the most profitable physical locations.
SELECT 
    s.store_name,
    s.store_city,
    SUM(f.total_amount) AS total_store_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_key = s.store_key
GROUP BY s.store_name, s.store_city
ORDER BY total_store_revenue DESC
LIMIT 2;


-- Q3: Month-over-month sales trend across all stores
-- This query shows the business growth (or decline) over time.
SELECT 
    d.year,
    d.month,
    SUM(f.total_amount) AS total_monthly_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month ASC;
