# RETAIL SALES ANALYSIS(SQL Project)
## Project Overview
This project explores and analyzes retail sales data using **SQL**.  
The dataset contains transactions including customer demographics, product categories, sales amounts, and timestamps.  
Through SQL queries, we uncover insights such as sales trends, customer behavior, and category performance.  
## 📊 Dataset
- **File:** `retail_sales.csv`  
- **Columns:**
  - `transactions_id` → Unique transaction ID  
  - `sale_date` → Date of transaction  
  - `sale_time` → Time of transaction  
  - `customer_id` → Unique customer ID  
  - `gender` → Customer gender  
  - `age` → Customer age  
  - `category` → Product category  
  - `quantity` → Units purchased  
  - `price_per_unit` → Price per unit  
  - `cogs` → Cost of goods sold  
  - `total_sale` → Final sale amount

  ### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales.csv``.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```
