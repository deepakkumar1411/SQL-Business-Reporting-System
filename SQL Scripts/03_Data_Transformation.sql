/*
===============================================================================
Project     : SQL Business Reporting System
File        : 03_Data_Transformation.sql
Author      : Deepak Kumar

Description :
Transforms raw data from the staging table into a reporting-ready table by
converting date columns into MySQL DATE format.
===============================================================================
*/

USE business_reporting;

-- Remove existing reporting table (optional)
DROP TABLE IF EXISTS sales_reporting;

-- Create reporting table
CREATE TABLE sales_reporting AS

SELECT

    Row_ID,
    Order_ID,

    STR_TO_DATE(Order_Date,'%d-%m-%Y') AS Order_Date,

    STR_TO_DATE(Ship_Date,'%d-%m-%Y') AS Ship_Date,

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

FROM sales_staging;

-- Verify transformed data
SELECT *
FROM sales_reporting
LIMIT 10;

-- Verify total records
SELECT COUNT(*) AS Total_Rows
FROM sales_reporting;

-- Verify table structure
DESCRIBE sales_reporting;