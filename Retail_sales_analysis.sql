-- SQL RETAIL SALES ANALYSIS

CREATE DATABASE retailsalesDB;

USE retailsalesDB;

 DROP TABLE IF EXISTS retail_sales;
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
        
 SELECT * FROM retail_sales;
 SELECT COUNT(*) FROM retail_sales;

-- DATA EXPLORATION

-- WHAT IS THE TOTAL NUMBER OF SALES RECORDED?
SELECT COUNT(*) AS total_sales FROM retail_sales; 
-- WHAT IS THE TOTAL NUMBER OF UNIQUE CUSTOMERS? 
SELECT COUNT(DISTINCT customer_id) AS customers FROM retail_sales;
-- WHAT ARE THE DISTINCT CATEGORIES PRESENT IN THE DATASET?
SELECT DISTINCT(category) FROM retail_sales;
-- WHAT IS THE AVERAGE SALES VALUE PER TRANSACTION?
SELECT ROUND(AVG(total_sale),2) AS average_sale_value FROM retail_sales;

-- DATA ANALYSIS AND IDENTIFICATION OF BUSINESS CHALLENGES

-- Q.1 WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'
SELECT * 
FROM retail_sales 
WHERE sale_date='2022-11-05';

-- Q.2 WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 2 IN THE MONTH OF NOV-2022
SELECT *
FROM retail_sales
WHERE category = 'clothing'
AND quantity > 2
AND YEAR(sale_date) = 2022 
AND MONTH(sale_date) = 11 ; 
 
-- Q.3 Write a SQL query to calculate the total sales for each category.
SELECT category,
	SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category='beauty';
 
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category,gender,COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category,gender
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
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

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
	category,
    COUNT(DISTINCT customer_id) AS count_unique_cs
    FROM retail_sales
    GROUP BY category;
    
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale AS (
  SELECT *,
    CASE
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM retail_sales
)
SELECT
  shift,
  COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

-- END OF PROJECT
