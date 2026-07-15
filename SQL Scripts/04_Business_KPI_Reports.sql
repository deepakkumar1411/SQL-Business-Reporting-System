/*
===============================================================================
Project     : SQL Business Reporting System
File        : 04_Business_KPI_Reports.sql
Author      : Deepak Kumar

Description :
Generates executive business reports including KPIs, monthly trends,
regional performance, and category analysis.
===============================================================================
*/

USE business_reporting;

/*=============================================================================
1. Executive KPI Report
=============================================================================*/

SELECT

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit,

COUNT(DISTINCT Order_ID) AS Total_Orders,

COUNT(DISTINCT Customer_ID) AS Total_Customers,

ROUND(SUM(Sales)/COUNT(DISTINCT Order_ID),2) AS Average_Order_Value,

ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percentage

FROM sales_reporting;


/*=============================================================================
2. Monthly Sales Performance
=============================================================================*/

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

MONTHNAME(Order_Date)

ORDER BY

Year,

Month_Number;


/*=============================================================================
3. Best Performing Months
=============================================================================*/

SELECT

YEAR(Order_Date) AS Year,

MONTHNAME(Order_Date) AS Month,

ROUND(SUM(Sales),2) AS Total_Sales

FROM sales_reporting

GROUP BY

YEAR(Order_Date),

MONTH(Order_Date),

MONTHNAME(Order_Date)

ORDER BY Total_Sales DESC

LIMIT 5;


/*=============================================================================
4. Regional Sales Performance
=============================================================================*/

SELECT

Region,

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit,

COUNT(DISTINCT Order_ID) AS Orders,

COUNT(DISTINCT Customer_ID) AS Customers

FROM sales_reporting

GROUP BY Region

ORDER BY Total_Sales DESC;


/*=============================================================================
5. Regional Profit Margin
=============================================================================*/

SELECT

Region,

ROUND(SUM(Sales),2) AS Sales,

ROUND(SUM(Profit),2) AS Profit,

ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin

FROM sales_reporting

GROUP BY Region

ORDER BY Profit_Margin DESC;


/*=============================================================================
6. Category Performance
=============================================================================*/

SELECT

Category,

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit,

SUM(Quantity) AS Units_Sold

FROM sales_reporting

GROUP BY Category

ORDER BY Total_Sales DESC;


/*=============================================================================
7. Sub-Category Performance
=============================================================================*/

SELECT

Category,

Sub_Category,

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit

FROM sales_reporting

GROUP BY

Category,

Sub_Category

ORDER BY Total_Sales DESC;


