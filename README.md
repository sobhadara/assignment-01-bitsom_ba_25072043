# assignment-01-bitsom_ba_25072043

# Retail Data Management & Analytics Project

This project demonstrates a full data lifecycle: from relational database design (SQL) and NoSQL document storage to modern Data Lakehouse architectures and automated data cleaning.

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
- **`etl_notes.md`**: Documentation of the Extract, Transform, and Load decisions made to clean raw transactional data.

### 📂 Part 4: Data Cleaning & Preprocessing
- **`embeddings_demo.py`**: Python script using Pandas to automate the cleaning of inconsistent retail datasets.
- **`cleaning_report.md`**: Summary of transformations, including handling null values, standardizing date formats, and correcting categorical casing.

### 📂 Part 5: Data Lake & DuckDB
- **`duckdb_queries.sql`**: High-performance "zero-copy" SQL queries performed directly on CSV, JSON, and Parquet files.
- **`architecture_choice.md`**: An analysis of Data Warehouse vs. Data Lake vs. Data Lakehouse architectures for a fast-growing delivery startup.

## Key Concepts Covered
- **ACID Compliance**: Ensuring reliable transactions in relational systems.
- **CAP Theorem**: Balancing Consistency, Availability, and Partition Tolerance in distributed databases.
- **Star Schema Design**: Separating quantitative measures (Facts) from descriptive attributes (Dimensions) for BI.
- **Modern Data Stack**: Utilizing **DuckDB** for analytical queries on multi-format data lakes without ingestion overhead.
- **Data Governance**: Understanding the role of **Object Storage** and **ACID transactions** in a Data Lakehouse environment.
