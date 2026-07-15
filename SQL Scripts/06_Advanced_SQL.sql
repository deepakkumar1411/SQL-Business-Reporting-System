/*
===============================================================================
Project     : SQL Business Reporting System
File        : 06_Advanced_SQL.sql
Author      : Deepak Kumar

Description :
Demonstrates advanced SQL concepts including Window Functions,
Common Table Expressions (CTEs), Ranking Functions, and
Partition-based analysis.
===============================================================================
*/

USE business_reporting;


/*=============================================================================
1. Customer Ranking by Sales
=============================================================================*/

SELECT

    Customer_Name,

    ROUND(SUM(Sales),2) AS Total_Sales,

    RANK() OVER
    (
        ORDER BY SUM(Sales) DESC
    ) AS Customer_Rank

FROM sales_reporting

GROUP BY Customer_Name;


/*=============================================================================
2. Product Ranking by Sales
=============================================================================*/

SELECT

    Product_Name,

    ROUND(SUM(Sales),2) AS Total_Sales,

    DENSE_RANK() OVER
    (
        ORDER BY SUM(Sales) DESC
    ) AS Product_Rank

FROM sales_reporting

GROUP BY Product_Name;


/*=============================================================================
3. Best Product in Each Category
=============================================================================*/

SELECT

    Category,

    Product_Name,

    ROUND(SUM(Sales),2) AS Total_Sales,

    ROW_NUMBER() OVER
    (
        PARTITION BY Category
        ORDER BY SUM(Sales) DESC
    ) AS Rank_In_Category

FROM sales_reporting

GROUP BY
    Category,
    Product_Name;


    /*=============================================================================
4. Top Product from Each Category
=============================================================================*/

WITH ProductRank AS
(

SELECT

    Category,

    Product_Name,

    ROUND(SUM(Sales),2) AS Total_Sales,

    ROW_NUMBER() OVER
    (
        PARTITION BY Category
        ORDER BY SUM(Sales) DESC
    ) AS Rank_In_Category

FROM sales_reporting

GROUP BY
    Category,
    Product_Name

)

SELECT

Category,

Product_Name,

Total_Sales

FROM ProductRank

WHERE Rank_In_Category = 1;


/*=============================================================================
5. Top 5 Customers
=============================================================================*/

WITH CustomerSales AS
(

SELECT

    Customer_Name,

    ROUND(SUM(Sales),2) AS Total_Sales,

    RANK() OVER
    (
        ORDER BY SUM(Sales) DESC
    ) AS Customer_Rank

FROM sales_reporting

GROUP BY Customer_Name

)

SELECT *

FROM CustomerSales

WHERE Customer_Rank <= 5;


/*=============================================================================
6. Running Sales Total
=============================================================================*/

SELECT

Order_Date,

ROUND(Sales,2) AS Sales,

ROUND(

SUM(Sales) OVER
(
ORDER BY Order_Date
)

,2)

AS Running_Total

FROM sales_reporting

ORDER BY Order_Date;


/*=============================================================================
7. Average Sales by Region
=============================================================================*/

SELECT

Region,

Customer_Name,

ROUND(Sales,2) AS Sales,

ROUND(

AVG(Sales) OVER
(
PARTITION BY Region
)

,2)

AS Regional_Average

FROM sales_reporting;


/*=============================================================================
8. Highest Sale within Each Region
=============================================================================*/

WITH RankedSales AS
(

SELECT

Region,

Customer_Name,

Sales,

ROW_NUMBER() OVER
(
PARTITION BY Region
ORDER BY Sales DESC
)

AS Rank_Number

FROM sales_reporting

)

SELECT *

FROM RankedSales

WHERE Rank_Number = 1;


