# Event-Data-Analysis-BigQuery-SQL-
Analyzed GA4-style event data with nested structures (ARRAY/STRUCT) to extract insights on user behavior, product performance, and session activity.
The goal is to extract meaningful insights from raw event logs and understand user behavior, product performance, and session-level activity using advanced SQL techniques.

---

## 🎯 Objectives

The analysis covers the following tasks:

### 1. Nested Data Exploration
- Explore GA4 event structure
- Work with nested and repeated fields
- Analyze `event_params`, `user_properties`, and `items` arrays

---

### 2. Array Analysis
- Calculate array sizes using `ARRAY_LENGTH`
- Analyze event structure complexity

---

### 3. Event Parameter Analysis
- Unnest `event_params`
- Extract key-value pairs
- Analyze frequency of event parameters

---

### 4. Product-Level Analysis
- Unnest `items` array
- Extract product information:
  - `item_name`
  - `item_category`
  - `price`
  - `quantity`

---

### 5. Product Performance Analysis
- Calculate:
  - product frequency
  - total quantity sold
  - total revenue
- Rank products by revenue

---

### 6. Category Filtering
- Filter events by product category
- Use `EXISTS` with `UNNEST` for array filtering

---

### 7. Time-Based Analysis
- Work with partitioned tables using `_TABLE_SUFFIX`
- Calculate daily:
  - unique users
  - total events
  - purchase events

---

### 8. User Spending Analysis
- Calculate total spending per user
- Apply ranking functions:
  - `RANK()`
  - `DENSE_RANK()`
  - `ROW_NUMBER()`

---

### 9. Session Analysis
- Extract `ga_session_id` from event parameters
- Order events within sessions
- Identify first events in sessions
- Analyze session start behavior

---

## 🛠 Methods & Techniques Used

- SQL (BigQuery Standard SQL)
- Nested data handling (`ARRAY / STRUCT`)
- `UNNEST` operations
- Window functions
- Aggregations and filtering
- Partitioned table analysis
- Session analysis

---

## 🔧 Tools & Libraries

- Google BigQuery
- SQL (Standard SQL)

---

## 📌 Dataset

`bigquery-public-data.ga4_obfuscated_sample_ecommerce`

Contains GA4 e-commerce event data including:
- User events
- Product interactions
- Event parameters
- Session information
- Purchase activity

---

## 💡 Key Insights

- Product performance differs significantly across items.
- Some users generate substantially higher revenue than others.
- Event parameters reveal important user interaction patterns.
- Session analysis helps identify common session entry events.
- Nested GA4 data can be transformed into structured analytical insights using SQL.
