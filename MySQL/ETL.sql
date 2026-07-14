# ETL Process
  
##Dataset Import

</> SQL
USE superstore_sales;

CREATE TABLE `Raw_Data_Sales` (
                    `Row_ID` text,
                    `Order_ID` text,
                    `Order_Date` text,
                    `Ship_Date` text,
                    `Ship_Mode` text,
                    `Customer_ID` text,
                    `Customer_Name` text,
                    `Segment` text,
                    `Country` text,
                    `City` text,
                    `State` text,
                    `Postal_Code` text,
                    `Region` text,
                    `Product_ID` text,
                    `Category` text,
                    `Sub_Category` text,
                    `Product_Name` text,
                    `Sales` text,
                    `Quantity` text,
                    `Discount` text,
                    `Profit` text
                    )  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET GLOBAL LOCAL_INFILE = ON;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_superstore_raw_UTF-8.csv'
INTO TABLE raw_data_sales
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

## Export Cleaned Data

</> SQL
SELECT 'Row_ID','Order_ID','Order_Date','Ship_Date','Ship_Mode',
       'Customer_ID','Customer_Name','Segment','Country','City',
       'State','Postal_Code','Region','Product_ID','Category',
       'Sub_Category','Product_Name','Sales','Quantity','Discount','Profit'
UNION ALL
SELECT Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode,
       	    Customer_ID, Customer_Name, Segment, Country, City,
       	    State, Postal_Code, Region, Product_ID, Category,
       	    Sub_Category, Product_Name, Sales, Quantity, Discount, Profit
FROM cleaned_data_sales
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_data_sales'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


