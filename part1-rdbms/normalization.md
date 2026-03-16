## Anomaly Analysis

### Insert Anomaly
**Example:** We cannot add a new Sales Representative (e.g., `SR04 - Sanjay Kumar`) to the system until they have processed at least one order. 
**Reason:** In this flat file, the primary identifier is essentially the `order_id`. Since an order cannot exist without a sales rep, and a sales rep's details are tied to orders, a new employee cannot be "inserted" into the database in isolation.

### Update Anomaly
**Example:** Sales Representative **SR01 (Deepak Joshi)** has inconsistent office addresses in the dataset.
- **Row 2 (ORD1114):** "Mumbai HQ, Nariman Point, Mumbai - 400021"
- **Row 38 (ORD1176):** "Mumbai HQ, Nariman Pt, Mumbai - 400021"
**Reason:** Because the address is repeated in every row associated with SR01, updating the address requires changing it in dozens of rows. If one row is missed (or abbreviated as seen here), the data becomes inconsistent.

### Delete Anomaly
**Example:** Product **P008 (Webcam)** appears only once in the dataset in **Order ORD1185** (Row 12).
**Reason:** If we delete order `ORD1185` (for example, if the customer cancelled), we lose all record of the Webcam product, its category, and its unit price (2100) from our catalog entirely.



## Normalization Justification

The argument that a single flat table is "simpler" is a common misconception that prioritizes short-term ease of viewing over long-term data integrity and system scalability. While a flat file like `orders_flat.csv` is easy to open in Excel, it is fundamentally flawed for a growing retail business.

Firstly, normalization prevents **data inconsistency**. In our dataset, Sales Rep `SR01` has two different addresses ("Nariman Point" vs "Nariman Pt"). In a flat table, updating an address requires a "search and replace" across thousands of rows; if one is missed, the database provides conflicting information. In a normalized 3NF schema, the address exists in exactly one place (the `SalesReps` table), making updates instantaneous and error-proof. This is called **UPDATE ANOMALY"**

Secondly, the flat structure suffers from **structural rigidity**. We cannot add a new product to our catalog unless someone orders it immediately **(Insert Anomaly)**, nor can we delete an old order without accidentally erasing our only record of a product's existence **(Delete Anomaly)**. For instance, deleting the single order for the **Webcam (P008)** would purge that product from our records entirely.

Finally, normalization significantly reduces **storage redundancy**. Storing "Anita Desai" and her full office address for every single order she handles wastes significant disk space. By moving these to a separate table, we store the text once and use a **small 4-byte ID** which is very space efficient and very faster to reference it. Therefore, normalization isn't over-engineering; it is the essential foundation for reliable, professional data management.
