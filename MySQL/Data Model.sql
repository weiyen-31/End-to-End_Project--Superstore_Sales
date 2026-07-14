# Data Modelling

## Create Staging Table（Cleaned Data）

</> SQL
CREATE TABLE `cleaned_data_sales` (
  `Row_ID` int,
  `Order_ID` text COLLATE utf8mb4_unicode_ci,
  `Order_Date` date,
  `Ship_Date` date,
  `Ship_Mode` text COLLATE utf8mb4_unicode_ci,
  `Customer_ID` text COLLATE utf8mb4_unicode_ci,
  `Customer_Name` text COLLATE utf8mb4_unicode_ci,
  `Segment` text COLLATE utf8mb4_unicode_ci,
  `Country` text COLLATE utf8mb4_unicode_ci,
  `City` text COLLATE utf8mb4_unicode_ci,
  `State` text COLLATE utf8mb4_unicode_ci,
  `Postal_Code` text COLLATE utf8mb4_unicode_ci,
  `Region` text COLLATE utf8mb4_unicode_ci,
  `Product_ID` text COLLATE utf8mb4_unicode_ci,
  `Category` text COLLATE utf8mb4_unicode_ci,
  `Sub_Category` text COLLATE utf8mb4_unicode_ci,
  `Product_Name` text COLLATE utf8mb4_unicode_ci,
  `Sales` DECIMAL (10,2),
  `Quantity` int,
  `Discount` DECIMAL (10,2),
  `Profit` DECIMAL (10,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `cleaned_data_sales`
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

FROM (
  SELECT *,
         ROW_NUMBER() OVER(PARTITION BY Order_ID, Product_ID 
         ORDER BY CAST(Row_ID AS UNSIGNED)) AS row_num
  FROM raw_data_sales) t
WHERE row_num = 1 ;

  
## Create dimension table - `customer`

</> SQL
CREATE TABLE `customers`(
  `Customer_ID` VARCHAR(50) PRIMARY KEY,
  `Customer_Name` VARCHAR(50),
  `Segment` VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `customers`
SELECT Customer_ID,
       Customer_Name,
       Segment
FROM (
  SELECT DISTINCT Customer_ID,
         Customer_Name,
         Segment
  FROM cleaned_data_sales 
  ) T;


## Create dimension table - `location`

</> SQL
CREATE TABLE `locations` (
  `Location_Key` INT AUTO_INCREMENT PRIMARY KEY, -- Surrogote Key
  `Country` VARCHAR(50),
  `City` VARCHAR(50),
  `State` VARCHAR(50),
  `Postal_Code` VARCHAR(50),
  `Region` VARCHAR(50),
  
  UNIQUE (Country, State, City, Postal_Code) -- Contraint
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `locations` (
  Country,
  City,
  State,
  Postal_Code，
  Region
  )
SELECT Country,
       City,
       State,
       Postal_Code,
       Region
FROM (
  SELECT DISTINCT Country,
         City,
         State,
         Postal_Code,
         Region
  FROM cleaned_data_sales
  ) T;


## Create dimension table - `products`

</> SQL
CREATE TABLE `products` (
  `Product_Key` INT AUTO_INCREMENT PRIMARY KEY,
  `Product_ID` VARCHAR(50),
  `Product_Name` VARCHAR(255),
  `Category` VARCHAR(50),
  `Sub_Category` VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `products`(
  Product_ID,
  Product_Name,
  Category,
  Sub_Category
  )
SELECT Product_ID,
       Product_Name,
       Category,
       Sub_Category
FROM (
  SELECT DISTINCT Product_ID,
         Product_Name,
         Category,
         Sub_Category
  FROM cleaned_data_sales
  ) T;


## Create FACT table - `orders`

</> SQL
CREATE TABLE `orders` (
  `Order_Key` INT AUTO_INCREMENT,
  `Order_ID` VARCHAR(50),
  `Customer_ID` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Product_Key` INT,
  `Product_ID` VARCHAR(50),
  `Order_Date` date,
  `Ship_Date` date,
  `Location_Key` INT,
  `Sales` DECIMAL (10,2),
  `Quantity` int,
  `Discount` DECIMAL (10,2),
  `Profit` DECIMAL (10,2),
  
  PRIMARY KEY (Order_Key),
  FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID),
  FOREIGN KEY (Location_Key) REFERENCES locations(Location_Key),
  FOREIGN KEY (Product_Key) REFERENCES products(Product_Key)
  );

INSERT INTO `orders` (
  Order_ID,
  Customer_ID,
  Product_ID,
  Product_Key,
  Order_Date,
  Ship_Date,
  Location_Key,
  Sales,
  Quantity,
  Discount,
  Profit
  )
SELECT Order_ID,
       Customer_ID,
       P.Product_ID,
       Product_Key,
       Order_Date,
       Ship_Date,
       Location_Key,
       Sales,
       Quantity,
       Discount,
       Profit
FROM cleaned_data_sales C
JOIN locations L
        ON C.Country = L.Country
        AND C.City = L.City
        AND C.State = L.State
        AND C.Postal_Code = L.Postal_Code
        AND C.Region = L.Region
JOIN products P
	ON C.Product_ID = P.Product_ID
   	AND C.Product_Name = P.Product_Name
   	AND C.Category = P.Category
   	AND C.Sub_Category = P.Sub_Category;
