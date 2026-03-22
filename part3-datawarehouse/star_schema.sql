
-- This allows you to run the script as many times as you like. It resets the environment by dropping existing tables before recreating them and loading the cleaned data.

-- ==========================================================
-- 1. Reset Schema (Drop tables in correct order)
-- ==========================================================
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_date;

-- ==========================================================
-- 2. Create Dimension Tables
-- ==========================================================
CREATE TABLE dim_product (
    product_key INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE dim_store (
    store_key INTEGER PRIMARY KEY AUTOINCREMENT,
    store_name VARCHAR(100),
    store_city VARCHAR(100)
);

CREATE TABLE dim_date (
    date_key INTEGER PRIMARY KEY, -- Formatted as YYYYMMDD
    full_date DATE,
    day INTEGER,
    month INTEGER,
    year INTEGER,
    quarter INTEGER
);

-- ==========================================================
-- 3. Create Fact Table
-- ==========================================================
CREATE TABLE fact_sales (
    fact_id INTEGER PRIMARY KEY AUTOINCREMENT,
    transaction_id VARCHAR(50),
    date_key INTEGER,
    product_key INTEGER,
    store_key INTEGER,
    units_sold INTEGER,
    unit_price DECIMAL(10, 2),
    total_amount DECIMAL(15, 2),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key)
);

-- ==========================================================
-- 4. INSERT Cleaned/Standardized Sample Data
-- ==========================================================

-- Populate dim_product (Standardized casing)
INSERT INTO dim_product (product_name, category) VALUES 
('Speaker', 'Electronics'), ('Tablet', 'Electronics'),
('Phone', 'Electronics'), ('Smartwatch', 'Electronics'),
('Atta 10kg', 'Groceries'), ('Milk 1L', 'Groceries');

-- Populate dim_store (Handling missing city data)
INSERT INTO dim_store (store_name, store_city) VALUES 
('Chennai Anna', 'Chennai'), ('Delhi South', 'Delhi'),
('Bangalore MG', 'Bangalore'), ('Pune FC Road', 'Pune');

-- Populate dim_date (Standardized YYYYMMDD keys)
INSERT INTO dim_date (date_key, full_date, day, month, year, quarter) VALUES 
(20230829, '2023-08-29', 29, 8, 2023, 3),
(20231212, '2023-12-12', 12, 12, 2023, 4),
(20230205, '2023-02-05', 5, 2, 2023, 1),
(20230115, '2023-01-15', 15, 1, 2023, 1),
(20230331, '2023-03-31', 31, 3, 2023, 1);

-- Populate fact_sales (10 cleaned transactional rows)
INSERT INTO fact_sales (transaction_id, date_key, product_key, store_key, units_sold, unit_price, total_amount) VALUES 
('TXN5000', 20230829, 1, 1, 3, 49262.78, 147788.34),
('TXN5001', 20231212, 2, 1, 11, 23226.12, 255487.32),
('TXN5002', 20230205, 3, 1, 20, 48703.39, 974067.80),
('TXN5004', 20230115, 4, 1, 10, 58851.01, 588510.10),
('TXN5005', 20230829, 5, 3, 12, 52464.00, 629568.00),
('TXN5006', 20230331, 4, 4, 6, 58851.01, 353106.06),
('TXN5281', 20230115, 3, 4, 12, 48703.39, 584440.68),
('TXN5283', 20230331, 4, 1, 3, 58851.01, 176553.03),
('TXN5285', 20231212, 6, 1, 18, 43374.39, 780739.02),
('TXN5286', 20230115, 5, 4, 18, 52464.00, 944352.00);