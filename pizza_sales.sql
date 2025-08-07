CREATE DATABASE PizzaDB;

USE PizzaDB;

SELECT * FROM pizza_sales;

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value FROM pizza_sales;

SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;

SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) 
/ CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)
)AS DECIMAL(10,2)) AS Average_Pizza_Per_Order 
FROM pizza_sales;

-- Daily Trend 
SELECT 
    DAYNAME(order_date) AS day_of_week,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    DAYNAME(order_date)
ORDER BY 
    FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Hourly Trend
SELECT 
    HOUR(order_time) AS hour_of_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    HOUR(order_time)
ORDER BY 
    HOUR(order_time);

-- Percentage of Sales by Pizza Category
SELECT pizza_category, sum(total_price) * 100 / (SELECT sum(total_price) from pizza_sales) as Total_Sales
from pizza_sales
WHERE month(order_date)= 1
GROUP BY pizza_category;
    
-- Percentage of Sales by Pizza Size:
SELECT 
    pizza_size,
    ROUND(SUM(total_price), 2) AS total_sales,
    ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS percentage
FROM 
    pizza_sales
GROUP BY 
    pizza_size
ORDER BY 
    percentage DESC;
    
-- Total Pizza Sold By Pizza Category 
SELECT pizza_category, sum(quantity) as Total_Pizzas_Sold from pizza_sales
Group by pizza_category;

-- Top 5 Best Sellers by Total Pizzas Sold
SELECT 
    pizza_name, 
    SUM(quantity) AS total_pizzas_sold 
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
    total_pizzas_sold DESC
LIMIT 5;

-- Bottom 5 Worst Sellers by Total Pizzas Sold
SELECT 
    pizza_name, 
    SUM(quantity) AS total_pizzas_sold 
FROM 
    pizza_sales
GROUP BY 
    pizza_name
ORDER BY 
    total_pizzas_sold ASC  
LIMIT 5;   
    
    
    
    
    
    
    
    
    
    
    
    