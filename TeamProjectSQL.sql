select *
From Store_locations_sheet;

SELECT *
FROM Customers_sheet;

SELECT *
FROM Products_Sheet;

SELECT *
FROM Sales_orders_sheet;

SELECT *
FROM sales_team_sheet;

SELECT *
FROM Regions_sheet;

SELECT *
FROM Walmart_retail_data

SELECT 
Sales_orders_sheet.salesteamid,

SUM(Sales_orders_sheet.unit_price) as TotalSales

FROM Sales_orders_sheet

GROUP BY salesteamid;


--Total Walmart Sales by State
CREATE VIEW TotalWalmartSalesbyState AS

SELECT 

state,

SUM(sales) as totalsales

FROM Walmart_retail_data

GROUP BY state

ORDER BY (totalsales) DESC;

--Total Product Sales By State
CREATE VIEW TotalProductSalesbyState AS 

SELECT 

Store_locations_sheet.state,

SUM(Sales_orders_sheet.unit_price) as totalsales

FROM Store_locations_sheet

INNER JOIN 

Sales_orders_sheet

ON Store_locations_sheet.storeid = Sales_orders_sheet.storeid

GROUP BY Store_locations_sheet.state

ORDER BY (totalsales) DESC;

--Average Lead Time Walmart by Region
CREATE VIEW AvgLeadTimeWalmart AS

SELECT 

region,

AVG (ship_date - order_date) AS leadtime

FROM Walmart_retail_data

GROUP BY region;

--Average Lead Time OtherGuys by Region
CREATE VIEW AvgLeadTimeOtherGuys AS

SELECT 

Sales_team_sheet.region,

AVG (Sales_orders_sheet.shipdate - Sales_orders_sheet.orderdate) AS leadtime

FROM Sales_team_sheet

LEFT JOIN  Sales_orders_sheet

ON Sales_orders_sheet.salesteamid = Sales_team_sheet.salesteamid

GROUP BY region;

