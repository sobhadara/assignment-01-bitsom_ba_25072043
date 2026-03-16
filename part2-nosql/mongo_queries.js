// OP1: insertMany() — insert all 3 documents from sample_documents.json

db.products.insertMany([
  {
    _id: "64e1001",
    product_id: "E1001",
    name: "Samsung 55-inch Smart TV",
    category: "Electronics",
    price: 65000,
    brand: "Samsung",
    specifications: {
      screen_size: "55 inches",
      resolution: "4K UHD",
      voltage: "220V"
    },
    warranty: {
      period: "2 years",
      type: "manufacturer"
    }
  },

  {
    _id: "64e1002",
    product_id: "C2001",
    name: "Men's Cotton T-Shirt",
    category: "Clothing",
    price: 899,
    brand: "Levi's",
    sizes_available: ["S","M","L","XL"],
    colors_available: ["Black","White","Blue"],
    material: "Cotton"
  },

  {
    _id: "64e1003",
    product_id: "G3001",
    name: "Organic Whole Milk",
    category: "Groceries",
    price: 70,
    brand: "Amul",
    weight: "1 litre",
    expiry_date: ISODate("2024-12-31"),
    nutritional_info: {
      calories: 60,
      protein: "3.2g",
      fat: "3.5g"
    }
  }
]);



// OP2: find() — retrieve all Electronics products with price > 20000

db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});



// OP3: find() — retrieve all Groceries expiring before 2025-01-01

db.products.find({
  category: "Groceries",
  expiry_date: { $lt: ISODate("2025-01-01") }
});



// OP4: updateOne() — add a "discount_percent" field to a specific product

db.products.updateOne(
  { product_id: "E1001" },
  { $set: { discount_percent: 10 } }
);



// OP5: createIndex() — create an index on category field and explain why

db.products.createIndex({ category: 1 });

// This index improves query performance when filtering products by category,
// such as retrieving all Electronics or Groceries products. Without an index,
// MongoDB must scan every document in the collection. The index allows MongoDB
// to quickly locate matching documents using the indexed field.
