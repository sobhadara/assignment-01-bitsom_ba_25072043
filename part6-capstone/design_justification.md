# 6.2 — Design Justification

## Storage Systems
To meet the hospital network’s four diverse goals, I have implemented a multi-tiered storage strategy that leverages the strengths of different database technologies:

1.  **Predicting Readmission Risk:** I utilized a **Data Lake** to store raw historical treatment data, EHR records, and clinical notes. This is essential for the **ML Model**, as it provides the large, diverse "training data" needed to identify patterns in patient history.
2.  **Plain English Doctor Queries:** I integrated an **NLP Interface / LLM** that interacts with both the **Data Lake** (for unstructured notes) and the **Data Warehouse** (for structured history). This allows the system to bridge the gap between textual clinical evidence and structured patient events.
3.  **Management Reporting:** For bed occupancy and department-wise costs, I chose a **Data Warehouse**. This system stores "Cleaned & Structured Data," allowing the **BI Reports Dashboard** to execute complex analytical queries quickly without being slowed down by raw logs.
4.  **Real-Time ICU Monitoring:** I implemented a dedicated **Time-Series Database** to store stream data from ICU devices. Vitals like heart rate and O2 levels are highly sequential and arrive at high frequency; a time-series DB is optimized for these rapid writes and allows for instant **Anomaly Detection** and alerts.



## OLTP vs OLAP Boundary
In this architecture, the boundary between the transactional (OLTP) and analytical (OLAP) systems occurs at the **Ingestion Layer**.

The **OLTP** side consists of the live **Data Sources**—the EHR systems and Billing databases—where hospital staff perform daily operations (admitting patients, updating charts). These systems are designed for high-concurrency and single-record updates.

The **OLAP** side begins once data passes through the **Batch ETL Pipeline** and the **Streaming Pipeline (Kafka)** into the **Storage Layer**. Once data enters the Data Lake and Data Warehouse, it is no longer used for day-to-day administrative updates; instead, it is transformed into a read-only format optimized for large-scale scanning, trend analysis, and machine learning.

## Trade-offs
A significant trade-off in this design is **System Complexity vs. Performance**. By using a specialized **Time-Series DB** and a **Streaming Pipeline (Kafka)** for ICU vitals, we introduce a "Speed Layer" that is separate from our "Batch Layer" (the Lake/Warehouse).

* **The Challenge:** Maintaining two different pathways for data (Batch and Stream) increases the engineering effort and the risk of data inconsistency between real-time alerts and end-of-month reports.
* **Mitigation:** To mitigate this, I have adopted a **Medallion Architecture** logic within the storage layer. By using a unified metadata layer and a **Single Source of Truth**, we ensure that both the streaming engine and the batch pipelines use the same data definitions. This ensures that a patient ID in a real-time alert perfectly matches the patient ID in a historical warehouse report.