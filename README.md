                                                 ## Pizza Sales Analysis Project
## Overview

This project provides a comprehensive analysis of pizza sales data through SQL queries and visualizations. It calculates key performance indicators (KPIs) and generates insights through various chart visualizations to understand business performance and customer preferences.

Key Features
KPI Calculation: 5 essential metrics for business performance

Trend Analysis: Daily and hourly order patterns

Sales Breakdown: By category and size

Product Performance: Top and bottom sellers

## SQL Queries
# KPI Calculations

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
       CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
       AS Average_Pizza_Per_Order FROM pizza_sales;

## Chart Data Queries

-- Daily Trend for Total Orders
SELECT DAYNAME(order_date) AS day_of_week,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date)
ORDER BY FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Hourly Trend for Total Orders
SELECT HOUR(order_time) AS hour_of_day,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);

-- Percentage of Sales by Pizza Category
SELECT pizza_category, 
       sum(total_price) * 100 / (SELECT sum(total_price) from pizza_sales) as Total_Sales
FROM pizza_sales
GROUP BY pizza_category;

-- Percentage of Sales by Pizza Size
SELECT pizza_size,
       ROUND(SUM(total_price), 2) AS total_sales,
       ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY percentage DESC;

-- Top 5 Best Sellers
SELECT pizza_name, SUM(quantity) AS total_pizzas_sold 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC
LIMIT 5;

-- Bottom 5 Worst Sellers
SELECT pizza_name, SUM(quantity) AS total_pizzas_sold 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold ASC
LIMIT 5;

# Visualization Requirements
Daily Order Trend: Bar chart showing orders by day of week

Hourly Order Trend: Line chart showing orders by hour

Sales by Category: Pie chart showing revenue distribution

Sales by Size: Pie chart showing size preferences

Top/Bottom Sellers: Bar charts comparing product performance

Usage Notes
All queries work with a standard pizza sales database table

Month filters can be applied using WHERE clauses (e.g., WHERE month(order_date)=1 for January)

Results can be exported directly to visualization tools

# Database Setup

CREATE DATABASE PizzaDB;
USE PizzaDB;
-- Import your pizza_sales data here
