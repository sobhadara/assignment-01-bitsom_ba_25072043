# assignment-01-bitsom_ba_25072043


# Retail Data Management & Analytics Project

This project demonstrates a full data lifecycle: from relational database design (SQL) to flexible document storage (NoSQL) and finally to data warehousing for business intelligence (Star Schema).

## Project Structure

### 📂 Part 1: Relational Database (SQL)
- **`schema.sql`**: Normalized table structures for a retail system.
- **`queries.sql`**: Standard SQL queries for daily business operations.
- **`normalization.md`**: Explanation of how the data was organized into 1NF, 2NF, and 3NF to ensure data integrity.

### 📂 Part 2: NoSQL Database (MongoDB)
- **`sample_documents.json`**: Product data stored in flexible JSON format, handling different product specifications.
- **`mongo_queries.js`**: Essential MongoDB operations including insertion, filtering, and indexing.
- **`rdbms_vs_nosql.md`**: A comparative analysis of ACID vs. BASE and a recommendation for a healthcare startup scenario.

### 📂 Part 3: Data Warehouse & ETL
- **`star_schema.sql`**: A dimensional model (Fact and Dimension tables) optimized for analytical reporting.
- **`dw_queries.sql`**: Complex OLAP queries to calculate revenue trends and store performance.
- **`etl_notes.md`**: Documentation of the Extract, Transform, and Load decisions made to clean the raw transactional data.

## Key Concepts Covered
- **ACID Compliance**: Ensuring reliable transactions in SQL.
- **CAP Theorem**: Balancing Consistency, Availability, and Partition Tolerance.
- **Star Schema Design**: Separating quantitative measures (Facts) from descriptive attributes (Dimensions).
- **Data Cleaning**: Handling inconsistent date formats, casing issues, and missing values.
