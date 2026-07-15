/*
===============================================================================
Project     : SQL Business Reporting System
File        : 01_Database_Setup.sql
Author      : Deepak Kumar

Description :
Creates the database and raw staging table used to import the Superstore
dataset before transformation into a reporting-ready table.
===============================================================================
*/

-- Create database
CREATE DATABASE IF NOT EXISTS business_reporting;

-- Select database
USE business_reporting;

-- Remove existing staging table (optional)
DROP TABLE IF EXISTS sales_staging;

-- Create raw staging table
CREATE TABLE sales_staging (

    Row_ID INT,
    Order_ID VARCHAR(30),

    Order_Date VARCHAR(20),
    Ship_Date VARCHAR(20),

    Ship_Mode VARCHAR(50),

    Customer_ID VARCHAR(30),
    Customer_Name VARCHAR(120),
    Segment VARCHAR(50),

    Country VARCHAR(60),
    City VARCHAR(60),
    State VARCHAR(60),

    Postal_Code VARCHAR(20),
    Region VARCHAR(40),

    Product_ID VARCHAR(30),

    Category VARCHAR(50),
    Sub_Category VARCHAR(50),

    Product_Name VARCHAR(255),

    Sales DECIMAL(12,4),

    Quantity INT,

    Discount DECIMAL(5,4),

    Profit DECIMAL(12,4)

);

-- Verify table creation
DESCRIBE sales_staging;