# ETL Process Notes

## ETL Decisions

### Decision 1 — Date Standardization
**Problem:** The raw data used many different **Date Formats**. Some rows used slashes (`29/08/2023`), some used dashes (`12-12-2023`), and others used a year-first format (`2023-02-05`). If dates are not the same, the computer cannot sort them or calculate monthly sales correctly.

**Resolution:** I performed a **Data Cleaning** step to convert every date into one standard format called **ISO 8601** (`YYYY-MM-DD`). I also created a **Date Key** (like `20230829`). This makes it easy for the **Fact Table** to connect to the **Dimension Table** so the business can filter data by Year, Month, or Quarter.

### Decision 2 — Categorical Casing and Grouping
**Problem:** There were **Inconsistent Labels** in the category column. For example, "electronics" (lowercase) and "Electronics" (capitalized) were listed as two different things. "Grocery" and "Groceries" were also split. In a report, this would wrongly show two separate bars for the same category.

**Resolution:** I applied a **Standardization** rule. I forced all text to "Proper Case" (starting with a capital letter). I merged "electronics" into "Electronics" and fixed "Grocery" to "Groceries." Now, when the business runs a query, all sales for the same category are grouped together correctly.

### Decision 3 — Handling Missing Geographical Data
**Problem:** There were **NULL Values** (missing information) in the city column. Some rows listed the store name as "Chennai Anna" but left the city blank. This is a problem because a "Sales by City" report would have a big "Unknown" section.

**Resolution:** I used a method called **Data Imputation**. Since I knew that "Chennai Anna" is always in the city of Chennai, I manually filled in the missing city names based on the store name. By fixing this before the **Load** phase, I ensured that the **Store Dimension** is 100% complete and the maps in the final report will be accurate.
