# Create Stores table and change the data type of open date 
CREATE TABLE `stores` (
  `StoreKey` int DEFAULT NULL,
  `Country` text,
  `State` text,
  `Square Meters` int DEFAULT NULL,
  `Open Date` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE stores 
ADD Open_Date_Clean DATE;
UPDATE stores
SET Open_Date_Clean = 
    CASE 
       WHEN `Open Date` LIKE '%-%' THEN STR_TO_DATE(`Open Date`, '%m-%d-%y')
       WHEN `Open Date` LIKE '%/%' THEN STR_TO_DATE(`Open Date`, '%m/%d/%Y')
	     ELSE NULL 
    END;
    
select * from stores;

# Create Sales table and change the data type of birthday date
use sales_detail;
CREATE TABLE `customers_ex2` (
  `CustomerKey` int DEFAULT NULL,
  `Gender` text,
  `Name` text,
  `City` text,
  `State Code` text,
  `State` text,
  `Zip Code` int DEFAULT NULL,
  `Country` text,
  `Continent` text,
  `Birthday` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE customers_ex2 
ADD Birthday_Date_Clean DATE;
UPDATE customers_ex2 
SET Birthday_Date_Clean = CASE 
   WHEN Birthday LIKE '__-__-____' THEN STR_TO_DATE(Birthday, '%d-%m-%Y')
   WHEN Birthday LIKE '__-__-__' THEN STR_TO_DATE(Birthday, '%d-%m-%Y')
   WHEN Birthday LIKE '%/%/%' THEN STR_TO_DATE(Birthday, '%e/%c/%Y')
   ELSE NULL 
END;

# create sales and convert the data type of delivery and order date to relevant data type
CREATE TABLE `sales` (
  `Order Number` int DEFAULT NULL,
  `Line Item` int DEFAULT NULL,
  `Order Date` text,
  `Delivery Date` text,
  `CustomerKey` int DEFAULT NULL,
  `StoreKey` int DEFAULT NULL,
  `ProductKey` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Currency Code` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE sales 
ADD Delivery_Date_Clean DATE;
UPDATE sales
SET Delivery_Date_Clean = 
    CASE 
        WHEN `Delivery Date` LIKE '%-%' THEN STR_TO_DATE(`Delivery Date`, '%m-%d-%y')
        WHEN `Delivery Date` LIKE '%/%' THEN STR_TO_DATE(`Delivery Date`, '%m/%d/%Y')
        ELSE NULL 
    END;
ALTER TABLE sales 
ADD Order_Date_Clean DATE;
UPDATE sales
SET Order_Date_Clean = 
    CASE 
        WHEN `Order Date` LIKE '%-%' THEN STR_TO_DATE(`Order Date`, '%m-%d-%y')
        WHEN `Order Date` LIKE '%/%' THEN STR_TO_DATE(`Order Date`, '%m/%d/%Y')
	      ELSE NULL 
    END;
    
