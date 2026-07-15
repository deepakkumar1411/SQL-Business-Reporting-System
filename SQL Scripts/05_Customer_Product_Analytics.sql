/*
===============================================================================
Project     : SQL Business Reporting System
File        : 05_Customer_Product_Analytics.sql
Author      : Deepak Kumar

Description :
Performs customer, product, shipping, and discount analysis to identify
top-performing customers, profitable products, shipping efficiency,
and the impact of discounts on profitability.
===============================================================================
*/

USE business_reporting;


/*=============================================================================
1. Top Customers by Sales
=============================================================================*/

SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM sales_reporting
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;


/*=============================================================================
2. Top Customers by Profit
=============================================================================*/

SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM sales_reporting
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Profit DESC
LIMIT 10;


/*=============================================================================
3. Top Products by Sales
=============================================================================*/

SELECT
    Product_ID,
    Product_Name,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM sales_reporting
GROUP BY Product_ID, Product_Name
ORDER BY Total_Sales DESC
LIMIT 10;


/*=============================================================================
4. Top Products by Profit
=============================================================================*/

SELECT
    Product_ID,
    Product_Name,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM sales_reporting
GROUP BY Product_ID, Product_Name
ORDER BY Total_Profit DESC
LIMIT 10;


/*=============================================================================
5. Least Profitable Products
=============================================================================*/

SELECT
    Product_ID,
    Product_Name,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM sales_reporting
GROUP BY Product_ID, Product_Name
ORDER BY Total_Profit
LIMIT 10;


/*=============================================================================
6. Average Delivery Time
=============================================================================*/

SELECT
    ROUND(AVG(DATEDIFF(Ship_Date,Order_Date)),2) AS Average_Delivery_Days
FROM sales_reporting;


/*=============================================================================
7. Delivery Performance by Ship Mode
=============================================================================*/

SELECT

    Ship_Mode,

    ROUND(AVG(DATEDIFF(Ship_Date,Order_Date)),2)
    AS Average_Delivery_Days,

    COUNT(*) AS Orders,

    ROUND(SUM(Sales),2) AS Total_Sales

FROM sales_reporting

GROUP BY Ship_Mode

ORDER BY Average_Delivery_Days;


/*=============================================================================
8. Orders by Ship Mode
=============================================================================*/

SELECT

    Ship_Mode,

    COUNT(*) AS Orders,

    ROUND(SUM(Sales),2) AS Total_Sales

FROM sales_reporting

GROUP BY Ship_Mode

ORDER BY Orders DESC;


/*=============================================================================
9. Profit by Discount
=============================================================================*/

SELECT

    Discount,

    ROUND(SUM(Sales),2) AS Total_Sales,

    ROUND(SUM(Profit),2) AS Total_Profit

FROM sales_reporting

GROUP BY Discount

ORDER BY Discount;


/*=============================================================================
10. Discount Band Analysis
=============================================================================*/

SELECT

CASE

WHEN Discount = 0 THEN 'No Discount'

WHEN Discount <= 0.20 THEN '0-20%'

WHEN Discount <= 0.50 THEN '20-50%'

ELSE 'Above 50%'

END AS Discount_Band,

ROUND(SUM(Sales),2) AS Total_Sales,

ROUND(SUM(Profit),2) AS Total_Profit

FROM sales_reporting

GROUP BY Discount_Band

ORDER BY Total_Sales DESC;


/*=============================================================================
11. Average Profit by Discount Band
=============================================================================*/

SELECT

CASE

WHEN Discount = 0 THEN 'No Discount'

WHEN Discount <= 0.20 THEN '0-20%'

WHEN Discount <= 0.50 THEN '20-50%'

ELSE 'Above 50%'

END AS Discount_Band,

ROUND(AVG(Profit),2) AS Average_Profit

FROM sales_reporting

GROUP BY Discount_Band;


