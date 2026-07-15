/*
===============================================================================
Project     : SQL Business Reporting System
File        : 02_Data_Import.sql
Author      : Deepak Kumar

Description :
Imports the Superstore CSV into the sales_staging table using
LOAD DATA LOCAL INFILE.
===============================================================================
*/

/*
NOTE:
Update the file path below to match the location of the Superstore CSV on your system.
*/

USE business_reporting;

-- Clear existing records
TRUNCATE TABLE sales_staging;

-- Import CSV file
LOAD DATA LOCAL INFILE
'C:/Users/Deepak Kumar/Downloads/Sample - Superstore.csv'

INTO TABLE sales_staging

FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'

IGNORE 1 LINES

(
    Row_ID,
    Order_ID,
    @OrderDate,
    @ShipDate,
    Ship_Mode,
    Customer_ID,
    Customer_Name,
    Segment,
    Country,
    City,
    State,
    Postal_Code,
    Region,
    Product_ID,
    Category,
    Sub_Category,
    Product_Name,
    Sales,
    Quantity,
    Discount,
    Profit
)

SET
    Order_Date = @OrderDate,
    Ship_Date = @ShipDate;

-- Verify import
SELECT COUNT(*) AS Total_Rows
FROM sales_staging;

-- Preview imported data
SELECT *
FROM sales_staging
LIMIT 10;