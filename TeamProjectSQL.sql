DROP TABLE IF EXISTS Customers_sheet;
DROP TABLE IF EXISTS Products_sheet;
DROP TABLE IF EXISTS Regions_sheet;
--DROP TABLE IF EXISTS Sales_orders_sheet;
DROP TABLE IF EXISTS Sales_team_sheet;
DROP TABLE IF EXISTS Store_locations_sheet;
DROP TABLE IF EXISTS Walmart_retail_data;

CREATE TABLE Walmart_retail_data (
	city VARCHAR NOT NULL,
	customer_name VARCHAR NOT NULL,
	customer_segment VARCHAR NOT NULL,
	discount DEC NOT NULL,
	number_of_records INT NOT NULL,
	order_date DATE NOT NULL,
	order_id INT NOT NULL,
	order_priority VARCHAR NOT NULL,
	order_quantity INT NOT NULL,
	product_base_margin DEC,
	product_category VARCHAR NOT NULL,
	product_container VARCHAR NOT NULL,
	--product_name VARCHAR NOT NULL,
	--product_sub_category VARCHAR NOT NULL,
	profit DEC NOT NULL,
	region VARCHAR NOT NULL,
	row_id INT NOT NULL,
	sales DEC NOT NULL, 
	ship_date DATE NOT NULL,
	ship_mode VARCHAR NOT NULL,
	shipping_cost DEC NOT NULL,
	state VARCHAR NOT NULL, 
	unit_price DEC NOT NULL,
	zip_code INT NOT NULL,
	CONSTRAINT pk_Walmart_retail_data PRIMARY KEY (
        row_id
     )
);

CREATE TABLE Sales_orders_sheet (
    ordernumber VARCHAR   NOT NULL,
    sales_channel VARCHAR   NOT NULL,
    warehousecode VARCHAR   NOT NULL,
    procureddate DATE   NOT NULL,
    orderdate DATE   NOT NULL,
    shipdate DATE   NOT NULL,
    deliverydate DATE   NOT NULL,
    currencycode VARCHAR   NOT NULL,
    salesteamid INT   NOT NULL,
    customerid INT   NOT NULL,
    storeid INT   NOT NULL,
    productid INT   NOT NULL,
    order_quantity INT   NOT NULL,
    discount_applied DEC   NOT NULL,
    unit_price DEC   NOT NULL,
    unit_cost DEC   NOT NULL,
    CONSTRAINT pk_Sales_orders_sheet PRIMARY KEY (
        ordernumber
     )
);

CREATE TABLE Customers_sheet (
    customerid INT   NOT NULL,
    customer_names VARCHAR   NOT NULL,
    CONSTRAINT pk_Customers_sheet PRIMARY KEY (
        customerid
     )
);

CREATE TABLE Store_locations_sheet (
    storeid INT   NOT NULL,
    city_name VARCHAR   NOT NULL,
    county VARCHAR   NOT NULL,
    statecode VARCHAR   NOT NULL,
    state VARCHAR   NOT NULL,
    type VARCHAR   NOT NULL,
    latitude DEC   NOT NULL,
    longitude DEC   NOT NULL,
    --location POINT   NOT NULL,
    areacode INT   NOT NULL,
    population INT   NOT NULL,
    household_income INT   NOT NULL,
    median_income INT   NOT NULL,
    land_area INT   NOT NULL,
    water_area INT   NOT NULL,
    time_zone VARCHAR   NOT NULL,
    CONSTRAINT pk_Store_locations_sheet PRIMARY KEY (
        storeid
    )
);

CREATE TABLE Products_sheet (
    productid INT   NOT NULL,
    product_name VARCHAR   NOT NULL,
    CONSTRAINT pk_Products_sheet PRIMARY KEY (
        productid
     )
);

CREATE TABLE Regions_sheet (
    statecode VARCHAR   NOT NULL,
    state VARCHAR   NOT NULL,
    region VARCHAR   NOT NULL,
    CONSTRAINT pk_Regions_sheet PRIMARY KEY (
        statecode
     )
);

CREATE TABLE Sales_team_sheet (
    salesteamid INT   NOT NULL,
    sales_team VARCHAR   NOT NULL,
    region VARCHAR   NOT NULL,
    CONSTRAINT pk_Sales_team_sheet PRIMARY KEY (
        salesteamid
     )
);

ALTER TABLE Sales_orders_sheet ADD CONSTRAINT fk_Sales_orders_sheet_salesteamid FOREIGN KEY(salesteamid)
REFERENCES Sales_team_sheet (salesteamid);

ALTER TABLE Sales_orders_sheet ADD CONSTRAINT fk_Sales_orders_sheet_customerid FOREIGN KEY(customerid)
REFERENCES Customers_sheet (customerid);

ALTER TABLE Sales_orders_sheet ADD CONSTRAINT fk_Sales_orders_sheet_storeid FOREIGN KEY(storeid)
REFERENCES Store_locations_sheet (storeid);

ALTER TABLE Sales_orders_sheet ADD CONSTRAINT fk_Sales_orders_sheet_productid FOREIGN KEY(productid)
REFERENCES Products_sheet (productid);



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

