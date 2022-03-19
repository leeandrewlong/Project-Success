-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/VGtCjU
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

DROP TABLE IF EXISTS "Customers_sheet";
DROP TABLE IF EXISTS "Products_sheet";
DROP TABLE IF EXISTS "Regions_sheet";
DROP TABLE IF EXISTS "Sales_orders_sheet";
DROP TABLE IF EXISTS "Sales_team_sheet";
DROP TABLE IF EXISTS "Store_locations_sheet";

CREATE TABLE "Sales_orders_sheet" (
    "ordernumber" VARCHAR   NOT NULL,
    "sales_channel" VARCHAR   NOT NULL,
    "warehousecode" VARCHAR   NOT NULL,
    "procureddate" DATE   NOT NULL,
    "orderdate" DATE   NOT NULL,
    "shipdate" DATE   NOT NULL,
    "deliverydate" DATE   NOT NULL,
    "currencycode" VARCHAR   NOT NULL,
    "salesteamid" INT   NOT NULL,
    "customerid" INT   NOT NULL,
    "storeid" INT   NOT NULL,
    "productid" INT   NOT NULL,
    "order_quantity" INT   NOT NULL,
    "discount_applied" DEC   NOT NULL,
    "unit_price" DEC   NOT NULL,
    "unit_cost" DEC   NOT NULL,
    CONSTRAINT "pk_Sales_orders_sheet" PRIMARY KEY (
        "ordernumber"
     )
);

CREATE TABLE "Customers_sheet" (
    "customerid" INT   NOT NULL,
    "customer_names" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Customers_sheet" PRIMARY KEY (
        "customerid"
     )
);

CREATE TABLE "Store_locations_sheet" (
    "storeid" INT   NOT NULL,
    "city_name" VARCHAR   NOT NULL,
    "county" VARCHAR   NOT NULL,
    "statecode" VARCHAR   NOT NULL,
    "state" VARCHAR   NOT NULL,
    "type" VARCHAR   NOT NULL,
    "latitude" DEC   NOT NULL,
    "longitude" DEC   NOT NULL,
    "location" POINT   NOT NULL,
    "areacode" INT   NOT NULL,
    "population" INT   NOT NULL,
    "household_income" INT   NOT NULL,
    "median_income" INT   NOT NULL,
    "land_area" INT   NOT NULL,
    "water_area" INT   NOT NULL,
    "time_zone" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Store_locations_sheet" PRIMARY KEY (
        "storeid"
     )
);

CREATE TABLE "Products_sheet" (
    "productid" INT   NOT NULL,
    "product_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Products_sheet" PRIMARY KEY (
        "productid"
     )
);

CREATE TABLE "Regions_sheet" (
    "statecode" VARCHAR   NOT NULL,
    "state" VARCHAR   NOT NULL,
    "region" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Regions_sheet" PRIMARY KEY (
        "statecode"
     )
);

CREATE TABLE "Sales_team_sheet" (
    "salesteamid" INT   NOT NULL,
    "sales_team" VARCHAR   NOT NULL,
    "region" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Sales_team_sheet" PRIMARY KEY (
        "salesteamid"
     )
);

ALTER TABLE "Sales_orders_sheet" ADD CONSTRAINT "fk_Sales_orders_sheet_salesteamid" FOREIGN KEY("salesteamid")
REFERENCES "Sales_team_sheet" ("salesteamid");

ALTER TABLE "Sales_orders_sheet" ADD CONSTRAINT "fk_Sales_orders_sheet_customerid" FOREIGN KEY("customerid")
REFERENCES "Customers_sheet" ("customerid");

ALTER TABLE "Sales_orders_sheet" ADD CONSTRAINT "fk_Sales_orders_sheet_storeid" FOREIGN KEY("storeid")
REFERENCES "Store_locations_sheet" ("storeid");

ALTER TABLE "Sales_orders_sheet" ADD CONSTRAINT "fk_Sales_orders_sheet_productid" FOREIGN KEY("productid")
REFERENCES "Products_sheet" ("productid");


