# Data Cleaning

## Check Duplicates and Remove
  
</> SQL
SELECT *
FROM (
	SELECT *,
		   ROW_NUMBER() OVER(PARTITION BY Order_ID, Product_ID
		   ORDER BY CAST(Row_ID AS UNSIGNED)) AS row_num
	FROM raw_data_sales) t
WHERE row_num = 1;


## Data Standardation and Consistency, Remove Unwanted Spaces and Handle Missing Value

SELECT CAST(Row_ID AS UNSIGNED) AS Row_ID, 
       Order_ID,
       CASE
          WHEN Order_Date REGEXP '^[0-9]{2}\\.[0-9]{2}\\.[0-9]{4}$' THEN
            CAST( STR_TO_DATE (
                NULLIF(TRIM(Order_Date),''),
            '%d.%m.%Y') AS DATE)
          WHEN Order_Date REGEXP '^[0-9]{8}$' THEN
            CAST(STR_TO_DATE (
                NULLIF(TRIM(Order_Date),''),
            '%Y%m%d') AS DATE)
          WHEN Order_Date REGEXP '^[0-9]{1,2}-[A-Za-z]{3}-[0-9]{2}$' THEN
            CAST( STR_TO_DATE (
                NULLIF(TRIM(Order_Date),''),
            '%d-%b-%y') AS DATE)
          WHEN Order_Date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4} [0-9]{1,2}:[0-9]{2}$' THEN
            CAST( STR_TO_DATE (
                NULLIF(TRIM(Order_Date),''),
            '%d/%m/%Y  %H:%i') AS DATE)
          ELSE NULL、
       END AS Order_Date,
       STR_TO_DATE(`Ship_Date`, '%d/%m/%Y') AS Ship_Date, 
       NULLIF (Ship_Mode, '') AS Ship_Mode, 
       CASE
          WHEN Customer_ID = '-RM19,750' THEN 'RM-19750'
          WHEN Customer_ID = '-RM19,675' THEN 'RM-19675'
          WHEN Customer_ID = '-RM19,375' THEN 'RM-19375'
          ELSE Customer_ID
      END AS Customer_ID,
      Customer_Name,
      CASE
          WHEN TRIM(Segment) IN ('Consumr','Counsumer') THEN 'Consumer'
          WHEN TRIM(Segment) IN ('Corp.','Corperate') THEN 'Corporate'
          WHEN TRIM(Segment) IN ('Home_Office','HomeOffice') THEN 'Home Office'
          ELSE TRIM(Segment)
      END AS Segment,
      CASE
          WHEN City = 'Vancouver' THEN REPLACE(Country,'United States','Canada')
          ELSE Country
	    END AS Country,
      City,
      State,
      CASE
          WHEN City = 'San Diego' THEN REPLACE(Postal_Code, '92024', '92037')
          ELSE Postal_Code
      END AS Postal_Code,
      Region,
      Product_ID,
      TRIM(Category) AS Category,
      TRIM(Sub_Category) AS Sub_Category,
      Product_Name,
      CAST(NULLIF(Sales,'') AS DECIMAL(10,2)) AS Sales,
      CAST(NULLIF(Quantity,'') AS UNSIGNED) AS Quantity,
      CAST(Discount AS DECIMAL(10,2)) AS Discount,
      CAST(NULLIF(Profit,'') AS DECIMAL (10,2)) AS Profit

