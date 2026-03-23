
// Essential MongoDB operations including insertion, filtering, and indexing.


print("\n===== MongoDB Assignment Execution =====\n");

// Ensure correct DB
use test;

// Clean existing collection first
db.products.deleteMany({})


//OP1: insertMany() — insert all 3 documents from sample_documents.json
print("OP1: Importing documents from json file...\n");

mongoimport --db test --collection products --file sample_documents.json --jsonArray

-- ==================================================================================

// OP2: find() — retrieve all Electronics products with price > 20000
print("OP2: Electronics with price > 20000\n");

db.products.find({category: "Electronics", base_price: { $gt: 20000 } }).forEach(doc => printjson(doc))

//printjson(db.products.find({category: "Electronics", base_price: { $gt: 20000 } }).toArray())

-- =================================================================================

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
print("\nOP3: Groceries expiring before 2025-01-01\n");

db.products.find({
  category: "Groceries",
  expiry_date: { $lt: "2025-01-01" }
}).forEach(doc => printjson(doc)) 

-- =================================================================================

// OP4: updateOne() — add a "discount_percent" field to a specific product
print("\nOP4: Adding discount_percent\n");

db.products.updateOne(
  { _id: "PROD_ELEC_101" },
  { $set: { discount_percent: 10 } }
)

-- ================================================================================

// OP5: createIndex() — create an index on category field and explain why
print("\nOP5: Creating index on category\n");

db.products.createIndex({ category: 1 })

print("Index created: " + indexName);

print("\n===== Execution Complete =====\n");