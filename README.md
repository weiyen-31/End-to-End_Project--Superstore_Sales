# Superstore Sales Dashboard

An end-to-end project built with MySQL and Power BI to transform raw retail sales data into an interactive dashboard for business decision-making.

This project covers the complete BI workflow from data cleaning and dimensional modelling to dashboard development and business insights.

## About the Project

Retail companies generate thousands of sales across different products, customers and locations every day. Then, it becomes increasingly difficult to monitor business performance using spreadsheets alone as the amount of data grows.

In this project, I built an end-to-end Business Intelligence solution that transforms raw sales data into an interactive Power BI dashboard to analyse sales performance, product profitability and customer behaviour within United States and Canada between 2023 and 2026.

Furthermore, this project follows a complete end-to-end BI process, including data preparation, dimensional modelling, DAX development and dashboard design.

## Business Questions

This dashboard was designed to answer questions such as:

1. How are sales and profit performing compared to last year?
2. Which products generate the highest and lowest profit?
3. Which customer segment contributes the most revenue?
4. Which states perform best in terms of sales?
5. How do sales change over time?
6. Who are the most valuable customers?
7. Which product categories sell the most?

## Dataset
Source: Kaggle Superstore Dataset

Industry: Retail

Data includes:
- Row ID	
- Order ID	
- Order Date	
- Ship Date	
- Ship Mode	
- Customer ID
- Customer Name	
- Segment	
- Country/Region	
- City	
- State/Province	
- Postal Code	
- Region	
- Product ID	
- Category	
- Sub-Category	
- Product Name	
- Sales	
- Quantity 
- Discount	
- Profit


## Project Workflow

<img width="439" height="482" alt="image" src="https://github.com/user-attachments/assets/c42b0033-93ad-4781-8f38-56bc2b549335" />


## Data Preparation

The dataset was first imported into MySQL Workbench for the initial data preparation purpose before building the dashboard in Power BI.

Some of the work included:

- Cleaning and organizing the raw data
- Standardizing data types
- Designed and implemented a Star Schema
- Created dimension and fact tables
- Generated surrogate keys for Dim Products, Dim Locations, and Fact Orders

Once the data model was ready, it was imported into Power BI for further transformation using Power Query.

Additional transformations included:

- Creating a Date dimension
- Formatting data types
- Renaming columns
- Preparing the model for DAX calculations

## Exploratory Data Analysis

Before building the dashboard, I explored the dataset to better understand its overall structure and identify key business trends from 2023 to 2025.

The initial analysis focused on:

- Sales distribution across states
  
  <img width="766" height="415" alt="image" src="https://github.com/user-attachments/assets/c3e29941-91a6-4f4e-9825-1cadf0214a72" />
  
  Helped identify high-performing states before designing the regional sales visual.

- Yearly sales and profit trends
  
  <img width="894" height="501" alt="image" src="https://github.com/user-attachments/assets/b0331da5-13a3-496e-b007-abb1942e8848" />

  Revealed seasonal sales patterns and fluctuations in profitability.

- Product category sold

  <img width="766" height="415" alt="image" src="https://github.com/user-attachments/assets/5c0b211a-fef1-4edb-b392-06327ab6957d" />

  Highlighted which product categories contributed the highest sales volume, helping prioritize category performance analysis.

- Customer segment distribution
  
  <img width="766" height="415" alt="image" src="https://github.com/user-attachments/assets/60627b81-3ab5-47e6-9c3d-5555324849ce" />

  Helped identify the dominant customer segment and understand the overall customer composition.

These findings helped shape the design of the final dashboard and determine the most relevant KPIs for business users.

## Data Model

The data model follows a Star Schema consisting of:

- 1 Fact Table
- 4 Dimension Tables

<img width="609" height="437" alt="image" src="https://github.com/user-attachments/assets/a4292106-ac04-48af-a713-beefa4579d35" />

Relationships: 

<img width="796" height="277" alt="image" src="https://github.com/user-attachments/assets/45d6e506-57d3-48fd-99bc-b8b0dcf700a5" />

## Dashboard

The report is divided into three pages, each page focusing on a different business area.
All dashboard screenshots are filtered to 2025 for consistency and presentation purposes. The Power BI report supports interactive analysis from 2023 to 2026.

### 1. Executive Overview

<img width="766" height="432" alt="image" src="https://github.com/user-attachments/assets/d5104b9e-3881-4c84-bc25-f5992baac584" />

The first page provides an overall view of business performance through key KPIs and trend analysis.

Highlights include:

- Total Sales
- Total Orders
- Total Profit
- Sales by State
- Orders by Segment
- Monthly Profit Trend
- Sales vs Orders Trend
- Product Quantity Sold

Users can also interact with the report using Year and Country slicers, as well as drill through by Category, Sub-Category, Year, Quarter and Month.

### 2. Product Performance

<img width="765" height="429" alt="image" src="https://github.com/user-attachments/assets/b3f08b80-e737-4753-97c7-efa7a4cdc919" />

This page designed to evaluate product profitability and identify top and bottom performing products.

It allows users to quickly identify:

- Top-performing products
- Lowest-performing products
- Most profitable sub-categories
- Running total sales
- Year-over-Year product growth
- Relationship between sales and profit

### 3. Customer Analysis

<img width="766" height="430" alt="image" src="https://github.com/user-attachments/assets/7dfe38df-cf02-41f4-99e0-5dd10c82d90c" />

The customer page helps understand customer behaviour and purchasing patterns.

It includes:

- Customer segmentation
- Repeat customer analysis
- Average order value
- Top customers by sales
- Sales vs Profit by customer

## DAX Measures

Some of the key measures created in this project include:

- YoY Sales
- YoY Orders
- YoY Profit
- Last Year Sales
- Last Year Orders
- Last Year Profit
- Running Total Sales
- Repeat Customers

These measures make it possible to compare historical performance, track cumulative sales and analyse customer loyalty.

## Key Insights

1. Sales increased compared to the previous year while profit declined, indicates profit margin pressure.
2. California generated the highest sales among all states.
3. Office Supplies recorded the highest quantity sold.
4. A few products generated strong sales but negative profit, indicates potential pricing or discount issues.
5. The Consumer segment contributed the largest share of customers and sales.
6. Repeat customers represented an important source of revenue highlighting the value of customer retention.

## Recommendations

1. Review pricing strategies for products with negative profit.
2. Increase focus on high-margin products and sub-categories.
3. Strengthen customer loyalty initiatives to encourage repeat purchases.
4. Continue investing in high-performing regions while investigating the causes of weaker-performing markets.

## Repository Structure

```
Superstore-Sales-Dashboard
│
├── Dataset
|    ├── Raw Data.csv
│    ├── Cleaned Data.csv
│
├── MySQL
│   ├── Data Cleaning.sql
│   ├── ETL.sql
│   ├── Data Model.sql
│
├── Power BI
│   └── Superstore Sales Dashboard.pbix
|   └── DAX Measures
│
├── Images
│   ├── Executive Dashboard.png
│   ├── Product Dashboard.png
│   ├── Customer Dashboard.png
│   ├── Star Schema.png
│
└── README.md
```

## Tools & Technologies

| Tool | Purpose |
|------|---------|
| MySQL Workbench | Data Cleaning, ETL & Data Modeling |
| Power BI | Dashboard Development |
| Power Query | Data Transformation |
| DAX | Business Calculations |
| Star Schema | Data Warehouse Modeling |
| GitHub | Version Control & Portfolio |

## Skills Demonstrated

- SQL
- ETL
- Data Cleaning
- Data Modeling
- Star Schema Design
- Surrogate Key Implementation
- Power Query
- DAX
- Power BI Dashboard Development
- Business Intelligence
- Data Visualization
- Business Analysis

