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
