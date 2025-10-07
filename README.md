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

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure


  ### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retailsalesDB``.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE retailsalesDB;

CREATE TABLE retail_sales 
		(
			transactions_id INT PRIMARY KEY, 
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(15),
			age INT,
			category VARCHAR(15),
			quantity INT,
		    price_per_unit FLOAT,	
		    cogs FLOAT,
			total_sale FLOAT
		);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales
WHERE category = 'clothing'
AND quantity > 2
AND YEAR(sale_date) = 2022 
AND MONTH(sale_date) = 11 ; 
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category,
	SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category='beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT category,
       gender,
       COUNT(*) AS total_trans
FROM retail_sales
GROUP BY
	category,
	gender
ORDER BY 1;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
WITH monthly_avg AS (
  SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    AVG(total_sale) AS avg_sale
  FROM retail_sales
  GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT year, month, avg_sale
FROM (
  SELECT
    year,
    month,
    avg_sale,
    RANK() OVER (PARTITION BY year ORDER BY avg_sale DESC) AS rnk
FROM monthly_avg
) AS t
WHERE rnk = 1
ORDER BY year;
```
8. **Write a SQL query to find the top 5 customers based on the highest total sales.**:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```
9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT
	category,
    COUNT(DISTINCT customer_id) AS count_unique_cs
    FROM retail_sales
    GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
```

## Key Findings

- **Customer Demographics:**  
  The dataset covers customers from diverse age groups, with sales distributed across categories such as **Clothing** and **Beauty**.  

- **High-Value Transactions:**  
  Several transactions exceeded **1000** in total sales, highlighting premium purchases that significantly contribute to revenue.  

- **Sales Trends:**  
  Monthly analysis reveals clear variations in sales, helping identify **peak seasons** and periods of high demand.  

- **Customer Insights:**  
  The analysis highlights the **top-spending customers** and uncovers the most **popular product categories**, providing valuable insights into customer preferences.
