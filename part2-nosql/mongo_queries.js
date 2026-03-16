// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "_id": "PROD_ELEC_101",
    "name": "Sony WH-1000XM5 Headphones",
    "category": "Electronics",
    "base_price": 25000,
    "specifications": { "brand": "Sony", "voltage": "110V-240V" }
  },
  {
    "_id": "PROD_CLOTH_202",
    "name": "Premium Cotton Crewneck Tee",
    "category": "Clothing",
    "base_price": 1500
  },
  {
    "_id": "PROD_GROC_303",
    "name": "Greek Style Yogurt",
    "category": "Groceries",
    "base_price": 450,
    "expiry_date": "2024-12-15"
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  "category": "Electronics",
  "base_price": { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  "category": "Groceries",
  "expiry_date": { $lt: "2025-01-01" }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { "_id": "PROD_ELEC_101" },
  { $set: { "discount_percent": 10 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ "category": 1 });

/* EXPLANATION: 
Creating an index on the 'category' field significantly improves query performance. 
Without an index, MongoDB must perform a 'Collection Scan' (reading every single 
document in the database) to find matches. With an index, MongoDB creates a 
sorted lookup structure that allows it to jump directly to the relevant 
documents, which is vital as the product catalog grows from 3 items to thousands.
*/
