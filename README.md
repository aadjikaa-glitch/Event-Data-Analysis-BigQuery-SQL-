# Event-Data-Analysis-BigQuery-SQL-
Analyzed GA4-style event data with nested structures (ARRAY/STRUCT) to extract insights on user behavior, product performance, and session activity.
The goal is to extract meaningful insights from raw event logs and understand user behavior, product performance, and session-level activity using advanced SQL techniques.
📊 Project Overview
This project focuses on analyzing GA4 event-based data to evaluate user interactions, product performance, and session behavior.
The main goal is to transform semi-structured event data into an analytical format and generate business insights such as high-value users, top-performing products, and key behavioral patterns.
🎯 Objectives
The analysis covers the following tasks:
1. Nested Data Exploration
Inspect GA4 event structure (event_params, user_properties, items)
Work with nested and repeated fields
Validate data completeness for selected users
2. Array & Structure Analysis
Calculate array sizes using ARRAY_LENGTH
Analyze complexity of event-level data structures
3. Event Parameter Analysis
Unnest event_params key-value pairs
Analyze frequency of event parameter usage
Identify most common tracking attributes
4. Product-Level Analysis
Unnest items array
Extract product-level attributes (item_name, category, price, quantity)
Analyze product performance
5. Revenue & Product KPIs
Calculate:
product occurrence frequency
total quantity sold
total revenue (price × quantity)
Rank products by performance
6. Category Filtering
Filter events based on product category (e.g. Apparel)
Use EXISTS with UNNEST for array-based filtering
7. Time-Based Analysis (Partitioned Data)
Work with partitioned tables (events_*)
Group data using _TABLE_SUFFIX
Calculate:
daily active users
total events
purchase events
8. User Value Analysis
Calculate total user spending
Apply ranking functions:
RANK()
DENSE_RANK()
ROW_NUMBER()
Identify top 20 highest-value users
9. Session Analysis
Extract ga_session_id from event parameters
Order events within sessions using window functions
Identify first event in each session
Analyze most common session start events
🧰 Methods & Techniques Used
SQL (BigQuery Standard SQL)
Nested data handling (ARRAY / STRUCT)
UNNEST operations
Window functions
Sessionization techniques
Time-based partition analysis
Aggregation & KPI calculations
🛠 Tools
Google BigQuery
SQL (Standard SQL)
GA4 e-commerce dataset
📌 Dataset
bigquery-public-data.ga4_obfuscated_sample_ecommerce
Contains GA4 e-commerce event data:
user interactions
product-level events
session tracking
event parameters
💡 Key Insights
Identified top-performing products based on revenue and quantity.
Found most frequently used event parameters in GA4 tracking.
Detected high-value users based on total spending.
Analyzed session behavior and session entry events.
Demonstrated how raw GA4 event logs can be transformed into structured business insights.
