/*
===============================================================================
Project     : SQL Business Reporting System
File        : 07_Database_Objects.sql
Author      : Deepak Kumar

Description :
Creates reusable database objects including SQL Views,
Stored Procedures, and Indexes to support business reporting
and improve query performance.
===============================================================================
*/

USE business_reporting;


/*=============================================================================
1. Monthly Sales View
=============================================================================*/

DROP VIEW IF EXISTS vw_monthly_sales;

CREATE VIEW vw_monthly_sales AS

SELECT

    YEAR(Order_Date) AS Year,

    MONTH(Order_Date) AS Month_Number,

    MONTHNAME(Order_Date) AS Month_Name,

    ROUND(SUM(Sales),2) AS Total_Sales,

    ROUND(SUM(Profit),2) AS Total_Profit,

    COUNT(DISTINCT Order_ID) AS Orders

FROM sales_reporting

GROUP BY

YEAR(Order_Date),

MONTH(Order_Date),

MONTHNAME(Order_Date);


/*=============================================================================
2. Regional Sales View
=============================================================================*/

DROP VIEW IF EXISTS vw_region_sales;

CREATE VIEW vw_region_sales AS

SELECT

Region,

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit,

COUNT(DISTINCT Order_ID) AS Orders,

COUNT(DISTINCT Customer_ID) AS Customers,

ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin

FROM sales_reporting

GROUP BY Region;


/*=============================================================================
3. Category Performance View
=============================================================================*/

DROP VIEW IF EXISTS vw_category_sales;

CREATE VIEW vw_category_sales AS

SELECT

Category,

Sub_Category,

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit,

SUM(Quantity) AS Units_Sold

FROM sales_reporting

GROUP BY

Category,

Sub_Category;


/*=============================================================================
4. Shipping Analysis View
=============================================================================*/

DROP VIEW IF EXISTS vw_shipping_analysis;

CREATE VIEW vw_shipping_analysis AS

SELECT

Ship_Mode,

ROUND(AVG(DATEDIFF(Ship_Date,Order_Date)),2)
AS Average_Delivery_Days,

COUNT(*) AS Orders,

ROUND(SUM(Sales),2) AS Total_Sales

FROM sales_reporting

GROUP BY Ship_Mode;


/*=============================================================================
5. Stored Procedure : Regional Sales
=============================================================================*/

DROP PROCEDURE IF EXISTS GetRegionSales;

DELIMITER //

CREATE PROCEDURE GetRegionSales
(
    IN p_region VARCHAR(50)
)

BEGIN

SELECT

Region,

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit,

COUNT(DISTINCT Order_ID) AS Orders

FROM sales_reporting

WHERE Region = p_region

GROUP BY Region;

END //

DELIMITER ;


CALL GetRegionSales('West');

CALL GetRegionSales('East');


/*=============================================================================
6. Indexes
=============================================================================*/

CREATE INDEX idx_order_date
ON sales_reporting(Order_Date);

CREATE INDEX idx_customer
ON sales_reporting(Customer_ID);

CREATE INDEX idx_region
ON sales_reporting(Region);


/*=============================================================================
7. Verification
=============================================================================*/

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SHOW INDEX
FROM sales_reporting;


